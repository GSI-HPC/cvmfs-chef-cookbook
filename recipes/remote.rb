#
# Cookbook:: cernvm-fs
# Recipe:: remote
#
# Copyright:: 2013-2023 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH
#
# Authors:
#  Christopher Huhn   <c.huhn@gsi.de>
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

# This variable contains the SSH configuration for the "cvmfs" user.
ssh_config = Hash.new

node['cvmfs']['remote'].each_pair do |repo,config|

  # by convention the maintainer group is called like the repository
  maintainer = repo.split('.')[0]
  # list of repository maintainers
  maintainers = config[:maintainer]
  group maintainer do
    members maintainers
  end

  directory "/cvmfs/#{repo}" do
    group maintainer
    mode '0775'
    recursive true
  end

  rsync_exclude = "/cvmfs/#{repo}.exclude"
  file rsync_exclude do
    mode "0770"
    group maintainer
    content ".svn/*\n.libs/*\n.deps/*\n*.o\n"
    # The excludes for Rsync will be modified by users eventually 
    not_if do ::File.exist? rsync_exclude end
  end

  # Define a host alias for each repository in the SSH configuration
  ssh_config[repo] = {
    'HostName' => config[:server],
    'UserKnownHostsFile' => '/dev/null',
    'StrictHostKeyChecking' => 'no'
  }

  # Allow all maintainers to execute the remote publishing script
  sys_sudo maintainer do
    users maintainer.upcase => maintainers
    rules ["#{maintainer.upcase} #{node['fqdn']}=NOPASSWD:/sbin/cvmfs-remote * #{repo}"]
  end

end

sys_ssh_config 'root' do
  config ssh_config
end

if node['cvmfs']['remote_key'].empty?
  Chef::Log.warn("No SSH login key to CVMFS servers provided")
else
  file '/root/.ssh/id_rsa' do
    content node['cvmfs']['remote_key'].gsub(/^ */,'').gsub(/^$\n/,'')
    mode '0600'
    backup false
  end
end

cookbook_file '/sbin/cvmfs-remote' do
  source 'cvmfs-remote'
  mode '0700'
  backup false
end

link "/sbin/cvmfs" do
  to "/sbin/cvmfs-remote"
end
