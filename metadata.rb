name             "cernvm-fs"
maintainer       'GSI Helmholtzzentrum fuer Schwerionenforschung GmbH'
maintainer_email "hpc@gsi.de"
license          "Apache 2.0"
description      "Deploy and configure CernVM-FS clients and servers."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://git.gsi.de:chef/cookbooks/cernvm-fs/'
issues_url       'https://git.gsi.de:chef/cookbooks/cernvm-fs/issues'

version          "0.5.0"

depends          "sys", '>= 1.51.0'
depends          "apache2", '< 6.0'
supports         "debian", ">= 7.0"
