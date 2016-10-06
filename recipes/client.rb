# Cookbook Name:: cernvm-fs
# Recipe:: client
# Author:: Victor Penso
# Copyright:: 2013-2015, GSI, HPC Department
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


case node.platform_version
when /^7.*/
  node.default['sys']['autofs']['maps']['/cvmfs']['map'] = '/etc/auto.cvmfs'
  include_recipe 'sys::autofs'
end

# Make sure the CMVFS user can use FUSE 
# to mount a repositories 
node.default['sys']['fuse']['config']['mount_max'] = 1000
node.default['sys']['fuse']['config']['user_allow_other'] = ''
include_recipe 'sys::fuse'

user 'cvmfs' do
  shell '/bin/bash'
  system true
end

group 'fuse' do
  # this should be a system group (ie. gid < 1000)
  system  true
  members 'cvmfs'
  append  true
end

execute 'modprobe fuse'

directory node.cvmfs.client.default_local.cache_base do
  owner 'cvmfs'
  group 'cvmfs'
  mode '0755'
  recursive true
end

template '/etc/cvmfs/default.local' do
  source 'etc_cvmfs_default.local.erb'
  mode "0644"
  variables( 
    :repos => node.cvmfs.client.config_d.keys,
    :config => node.cvmfs.client.default_local
  )
end

directory '/etc/cvmfs/config.d'

# Each repository needs its configuration file
unless node.cvmfs.client.config_d.empty?
  node.cvmfs.client.config_d.each do |repo,config|

    config['http_proxy'] = 'DIRECT' unless config.has_key? 'http_proxy'

    template "/etc/cvmfs/config.d/#{repo}.conf" do
      source 'etc_cvmfs_config.d_generic.conf.erb'
      mode "0644"
      variables( :repo => repo, :config => config )
    end


  end
end

