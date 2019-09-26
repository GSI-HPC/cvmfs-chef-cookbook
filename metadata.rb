name             "cernvm-fs"
maintainer       "GSI, HPC Department"
maintainer_email "hpc@gsi.de"
license          "Apache 2.0"
description      "Deploy and configure CernVM-FS clients and servers."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"
depends          "sys", '>= 1.51.0'
depends          "apache2", '< 6.0'
supports         "debian", ">= 7.0"
