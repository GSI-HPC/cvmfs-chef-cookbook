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
