# Cookbook Name:: cernvm-fs
# Recipe:: server
#
# Author Victor Penso
#
# Copyright 2013, GSI, HPC Department
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

include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_expires'

# Initialize the repositories unless they exist
node.cvmfs.server.repos.each do |repo|
  execute "cvmfs_server mkfs -o root #{repo}" do
    not_if do ::File.directory? "/etc/cvmfs/repositories.d/#{repo}" end
  end
end
