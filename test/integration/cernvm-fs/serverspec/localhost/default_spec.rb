require 'spec_helper'

# TODO: find a good way to determine which variant of CVMFS we have installed
#  `grep-status -s Package,Status -P cvmfs-release` ???
# For now:
if true
  cvmfs_client_package = 'cvmfs'
else
  cvmfs_client_package = 'cvmfs-client'
end

describe package(cvmfs_client_package) do
  it { should be_installed }
end

describe file('/etc/auto.master') do
  it { should exist }
  it { should contain %r{^/cvmfs.*auto.cvmfs} }
end
