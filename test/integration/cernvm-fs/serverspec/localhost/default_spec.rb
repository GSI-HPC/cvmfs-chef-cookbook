#
# Cookbook Name:: cernvm-fs
#
# Copyright 2019-2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH
#
# Authors:
#  Christopher Huhn   <C.Huhn@gsi.de>
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

require 'spec_helper'

@package_name = case os[:release]
                when /^[7-9]\./
                  'cvmfs-client'
                else
                  'cvmfs'
                end

describe package(@package_name) do
  it { should be_installed }
end

describe file('/etc/auto.master.d/cvmfs.autofs') do
  it { should exist }
  it { should contain %r{^/cvmfs.*auto.cvmfs} }
end

describe file('/cvmfs') do
  it { should exist }
  it { should be_directory }
end

describe command('cvmfs_config chksetup') do
  its(:exit_status) { should be_zero }
end

describe command('automount -m') do
  before do
    `systemctl reload autofs.service`
  end
  its(:exit_status) { should be_zero }
  its(:stderr) { should be_empty }
  its(:stdout) { should contain "Mount point: /cvmfs" }
  its(:stdout) { should contain "map: /etc/auto.cvmfs" }
end

describe file('/cvmfs/cvmfs-config.cern.ch') do
  it { should be_directory }
end

describe command('cvmfs_config probe') do
  its(:exit_status) { should be_zero }
  its(:stderr) { should be_empty }
end
