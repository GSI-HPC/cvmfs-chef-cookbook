#
# Cookbook Name:: cernvm-fs
# Recipe:: apt_repository
#
# Copyright 2020-2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH
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
#
# Set up the CERN CVFMS package repository
#

package 'gnupg'

if node['platform'] == 'debian' && node['platform_version'].to_i < 10
  # everything before buster:

  # Deploy the APT key for `gsi-repository`
  sys_apt_key "Deploy APT key for the GSI package repository" do
    key <<KEY
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.12 (GNU/Linux)

mQENBFidegQBCADOdF8kqd2KtAdc1kF5I/bvKpb9urStw93EKua6YoalYmCYMNfg
x9pq9Np+dqr52ph/LN9AWICe3oHwUGRKU3vE9S15LXrKtgdmAYedEJKIliLt8H9i
BZF2Ma0JK/Nk5mMzK0W1n2gcDEg1GmK+/XWYzKCMsdearrIU8LJ9+iQHBEydLJIO
vqP2pvsGWxj5ogY9X+q23+ZzzHgH6SMIpwM+iKQa22bm1nHm8J9eWMJBKBFz1sX4
dWQvhkY6NgUg6unGDWF+RLOJhT31fPMiEB4vB6tKXSI0PYHNLrpERgG8Sl4/EFdk
ONHcfjmFnWbQ/X9udtRXwBmFvDNfZ0hYI41nABEBAAG0M0dTSSByZXBvc2l0b3J5
IHNpZ25pbmcga2V5IDIwMTcgPGxpbnV4Z3JvdXBAZ3NpLmRlPokBPQQTAQgAJwUC
WJ16BAIbAwUJCWYBgAULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRCrZFFowbvN
DkGyCACtYMTeSuyls2PzbYOgO3PRnOCdG8D+iqwAvLI8BL8HNITobm9bIIwTslwu
0QvZc8Jb53LL1USF9uSmqCK0miHexH4Gaybc1WFM1o4xvqzneQlVOWyrq8oqKEB6
wBuHEbpCi+9i8fIfnVbKd3r+IbE/9W5JcSmWDItywz7ei1v1/ZXb27/FgxgcPtnh
CBgXEeEIL8s7SCM1CsR+d87sc7dIATBERK+nGVxTKwnQntWrqk5p2Oq3fJ0NU8kJ
3yHCZ0ll93J7lZLX4pCbdLdLPiw3/DMvR4QzqEuH0HnzBc52OdF/HJ4acM7adv0K
TqAhv92xvOIhIXrSMzovp29qSkZP
=O1Gt
-----END PGP PUBLIC KEY BLOCK-----
KEY
  end

  sys_apt_repository 'cvmfs' do
    config  "deb\thttp://mirror.gsi.de/distrib/gsi-repository "\
            "#{node['lsb']['codename']} main"
  end
else
  # Buster and beyond:
  package 'apt-transport-https'

  apt_repository 'cvmfs' do
    uri          node['cvmfs']['apt']['repository']['uri']
    distribution node['lsb']['codename'] + '-prod'
    components   %w[main]
    key          'cvmfs-repo.asc'
  end
end
