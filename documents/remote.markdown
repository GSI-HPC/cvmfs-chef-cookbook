Keep software build systems in sync with a CVMFS repository server.

↪ `attributes/remote.rb`  
↪ `recipes/remote.rb`  
↪ `files/default/cvmfs-remote.rb`  
↪ `tests/roles/cvmfs_remote_test.rb`

Attributes
----------

All attributes in `node.cvmfs`:

* `remote` (required) – Hash containing a list of CVMFs repository servers. 
* `remote_key` (optional) – SSH private key used to login to the CVMFS repository servers. 

Example
-------

Each element in `node.cvmfs.remote` requires a `server` host name and a list of users `maintainer` allowed to modify the local software directory, and to synchronise with the CVMFS server.

    :cvmfs => {
      :remote => {
        "alpha.devops.test" => {
          :server => "lxfs01.devops.test",
          :maintainer => [ 'skywalker','solo' ]
        },
        "betta.devops.test" => {
          :server => 'lxfs02.devops.test',
          :maintainer => [ 'lea', 'joda' ]
        }
      },
      :remote_key => '…'
    […]

