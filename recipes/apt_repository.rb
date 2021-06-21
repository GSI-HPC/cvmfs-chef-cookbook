#
#
#

package 'gnupg'

apt_repository 'cvmfs' do
  uri          'http://cvmrepo.web.cern.ch/cvmrepo/apt'
  distribution node['lsb']['codename'] + '-prod'
  components   %w[main]
  key          'cvmfs-repo.asc'
end
