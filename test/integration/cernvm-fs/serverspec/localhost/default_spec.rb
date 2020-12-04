require 'spec_helper'

describe package('cvmfs') do
  it { should be_installed }
end

describe file('/etc/auto.master') do
  it { should exist }
  it { should contain %r{^/cvmfs.*auto.cvmfs} }
end
