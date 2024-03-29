#
# Cookbook Name:: cernvm-fs
# Recipe:: client
#
# Copyright 2013-2023 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH
#
# Authors:
#  Matteo Dessalvi   <m.dessalvi@gsi.de>
#  Christopher Huhn  <c.huhn@gsi.de>
#  Walter Karig
#  Bastian Neuburger <b.neuburger@gsi.de>
#  Matthias Pausch   <m.pausch@gsi.de>
#  Victor Penso      <v.penso@gsi.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_version'].to_i
when 7
  node.default['sys']['autofs']['maps']['cvmfs'] = {}
  include_recipe 'sys::autofs'
when 9..99
  directory '/etc/auto.master.d'

  file '/etc/auto.master.d/cvmfs.autofs' do
    content <<-EOF
# generated by Chef, cernvm-fs cookbook
/cvmfs program:/etc/auto.cvmfs
EOF
    notifies :reload, 'service[autofs]'
  end

  service 'autofs' do
    action :nothing
  end
end

user 'cvmfs' do
  shell '/usr/sbin/nologin'
  system true
end

if node['platform'] == 'debian' && node['platform_version'].to_i < 11
  # Make sure the CMVFS user can use FUSE
  # to mount a repositories
  node.default['sys']['fuse']['config']['mount_max'] = 1000
  node.default['sys']['fuse']['config']['user_allow_other'] = ''
  include_recipe 'sys::fuse'

  group 'fuse' do
    # this should be a system group (ie. gid < 1000)
    system  true
    members 'cvmfs'
    append  true
  end

  execute 'modprobe fuse' do
    not_if 'grep -q "^fuse\>" /proc/modules'
  end
end

directory node['cvmfs']['client']['default_local']['cache_base'] do
  owner 'cvmfs'
  group 'cvmfs'
  mode '0755'
  recursive true
end

# make sure CVMFS_HTTP_PROXY is defined:
node.default_unless['cvmfs']['client']['default_local']['http_proxy'] = 'DIRECT'

template '/etc/cvmfs/default.local' do
  source 'etc_cvmfs_default.local.erb'
  mode "0644"
  variables(
    :repos => node['cvmfs']['client']['config_d'].keys,
    :config => node['cvmfs']['client']['default_local']
  )
end


#
# Domain configs:
#
directory '/etc/cvmfs/domain.d'

node['cvmfs']['client']['domain_d'].each do |repo, config|

  # config['local'] = true will create a repo.local
  #  leaving an existing repo.conf intact:
  domain_d = "/etc/cvmfs/domain.d/" + repo +
             (config['local'] ? '.local' : '.conf')

  template domain_d do
    source 'etc_cvmfs_config.d_generic.conf.erb'
    mode "0644"
    variables(config: config)
  end

end


#
# Repository configs
#
directory '/etc/cvmfs/config.d'

# delete repo configs not managed by this cookbook:
Dir.glob('/etc/cvmfs/config.d/*.conf').each do |f|
  file f do
    action :delete
    only_if { node['cvmfs']['client']['config_d_cleanup'] == true }
    # keep files with a correspoming attribute:
    not_if do
      node['cvmfs']['client']['config_d'].key?(File.basename(f,'.conf'))
    end
  end
end

# Each repository needs its configuration file
node['cvmfs']['client']['config_d'].each do |repo, config|
  template "/etc/cvmfs/config.d/#{repo}.conf" do
    source 'etc_cvmfs_config.d_generic.conf.erb'
    mode "0644"
    variables(config: config)
  end
end
