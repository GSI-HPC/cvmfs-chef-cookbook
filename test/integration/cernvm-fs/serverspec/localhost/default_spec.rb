require 'spec_helper'

describe package('cvmfs-client') do
  it { should be_installed }
end

describe file('/etc/auto.master.d/cvmfs.autofs') do
  it { should exist }
  it { should contain %r{^/cvmfs.*auto.cvmfs} }
end

describe command('automount -m') do
  its(:exit_status) { should be_zero }
  its(:stdout) { should contain 'Mount point: /cvmfs' }
end
