require 'spec_helper'

describe package('cvmfs') do
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
