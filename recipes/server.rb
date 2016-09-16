# Cookbook Name:: cernvm-fs
# Recipe:: server
#
# Author Victor Penso
#
# Copyright 2013-2015, GSI, HPC Department
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

  include_recipe 'apache2'
  include_recipe 'apache2::mod_rewrite'
  include_recipe 'apache2::mod_expires'

  apache_site "000-default" do
    enable false
  end

when /^8.*/

  # There is no need for a specific Apache configuration,
  # Debian default configuration is sufficient...

  package 'cvmfs-server'

  template '/etc/apache2/conf-available/cvmfs-fix-mime-type.conf' do
    source 'etc_apache2_conf-available_cvmfs-fix-mime-type.conf.erb'
    mode 0644
    notifies :run, 'execute[enable cvmfs fix]', :immediately
  end

  execute 'enable cvmfs fix' do
    command 'a2enconf cvmfs-fix-mime-type'
    action :nothing
    notifies :reload, 'service[apache2]', :immediately
  end

  service 'apache2' do
    supports ({ :reload => true })
    action [:enable, :start]
  end
end

# Initialize the repositories unless they exist
node.cvmfs.server.repos.each do |repo|
  execute "cvmfs_server mkfs -o root #{repo}" do
    not_if do ::File.directory? "/etc/cvmfs/repositories.d/#{repo}" end
  end
end

# Setup a cron job to resign the repos every 20 days to avoid expired
# catalog signatures
cookbook_file '/etc/cron.d/cvmfs-resign' do
  source 'etc_cron.d_cvmfs-resign'
  mode 0644
end
