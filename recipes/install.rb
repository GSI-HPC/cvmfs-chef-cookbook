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

unless ::File.exists? '/etc/cvmfs/default.conf'
  cookbook_file '/usr/local/src/cvmfs-install' do
    source 'cvmfs-install'
    mode '0755'
  end
  # This is a self-contained shell script installing 
  # CVMFS from a source code tar ball downloaded
  # from the developers web-site.
  execute "/usr/local/src/cvmfs-install #{node.cvmfs.version}"
end

