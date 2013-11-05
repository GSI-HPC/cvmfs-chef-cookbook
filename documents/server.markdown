Server Guide
============

Deploy and configure a CernVM-FS server.

↪ `attributes/server.rb`  
↪ `recipes/server.rb`  
↪ `tests/roles/cvmfs_server_test.rb`

Attributes
----------

Initialize a list of CVMFS repositories defined by the attribute `cvmfs.server.repos`.

For example:

    :cvmfs => {
      :server => {
        :repos => [ 
          'alpha.devops.test',
          'betta.devops.test'
        ]
      } 
    }

Make sure to backup the repository key-pair from `/etc/cvmfs/keys`, and to distribute the public key to all clients.

