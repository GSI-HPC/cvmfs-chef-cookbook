name             "cernvm-fs"
maintainer       "GSI, HPC Department"
maintainer_email "hpc@gsi.de"
license          "Apache 2.0"
description      "Deploya and configure  CernVM-FS clients and servers."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.9"
depends          "sys"
depends          "apache2", "~> 1.8"
supports         "debian", ">= 7.0"
