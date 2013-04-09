#
# Cookbook Name:: cvmfs
# Recipe:: default
#
# Copyright 2013, Victor Penso
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

unless node.cvmfs.server.version.empty?
  version =  node.cvmfs.server.version
  unless ::File.exists? '/etc/cvmfs'
    cookbook_file '/usr/local/src/cvmfs-install' do
      source 'cvmfs-install'
      mode '0755'
    end
    # This is a self-contained shell script installing 
    # CVMFS from a source code tar ball downloaded
    # from the developers web-site.
    execute "/usr/local/src/cvmfs-install #{version}"
  end
end

include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_expires'

apache_site '000-default' do
  enable false
end

# This could be done with a dedicated cookbook 
if node.cvmfs.server.proxy.enable

  package 'squid3'

  template '/etc/squid3/squid.conf' do
    source 'etc_squid3_squid.conf.erb'
    mode '0644'
    variables :access => node.cvmfs.server.proxy.access
    notifies :restart, 'service[squid3]'
  end

  service 'squid3' do
    supports :restart => true
    action :enable
  end

end

