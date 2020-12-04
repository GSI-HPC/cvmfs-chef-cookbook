#
# Cookbook Name:: cernvm-fs
# Recipe:: default
#
# Copyright 2013-2020 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH
#
# Authors:
#  Matteo Dessalvi    <m.dessalvi@gsi.de>
#  Christopher Huhn   <C.Huhn@gsi.de>
#  Dennis Klein       <d.klein@gsi.de>
#  Matthias Pausch    <m.pausch@gsi.de>
#  Victor Penso       <v.penso@gsi.de>
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
unless node[:cvmfs][:version].empty?
  include_recipe 'cernvm-fs::install'
else
  package 'cvmfs'
end

# Deploy files to the /etc/cvmfs/keys directory
directory '/etc/cvmfs/keys' do
  recursive true
end

node[:cvmfs][:keys].each do |name,key|
  file "/etc/cvmfs/keys/#{name}" do
    mode "0644"
    content key.gsub(/^ */,'')
  end
end

if node[:cvmfs][:server][:repos].empty?
  include_recipe 'cernvm-fs::client'
else
  include_recipe 'cernvm-fs::server'
end
