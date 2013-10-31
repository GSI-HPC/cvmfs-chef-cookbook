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

# Install from source if a specific version is defined 
unless node.cvmfs.version.empty?
  include_recipe 'cernvm-fs::install'
# Otherwise it is assumed a package can be installed
else
  package 'cvmfs'
end

if node.cvmfs.server.repos.empty?
  include_recipe 'cernvm-fs::client'
else
  include_recipe 'cernvm-fs::server'
end
