CernVM-FS Clients
=================

Mount CernVM-FS repositories on a node.

↪ `attributes/clients.rb`  
↪ `recipes/clients.rb`  
↪ `templates/default/etc_cvmfs_default.local.erb`  
↪ `templates/default/etc_cvmfs_config.d_generic.local.erb`  
↪ `tests/roles/cvmfs_client_test.rb`

Attributes
----------

Default configuration affecting all mounted repositories
is defined with attributes in `node.cvmfs.default_local`,
and written to `/etc/cvmfs/default.local`.

* `cache_base` (default `/var/cache/cvmfs`) – Path to the local repository cache.
* `quota_limit` (default 20000) – Maximum local storage consumes by a repository (in MB).
* `max_ttl` (default 30) – Metadata synchronisation interval (in minutes).

Defining a repository in `node.cvmfs.client.config_d` will render a
configuration file in `/etc/cvmfs/config.d/*.local`. (Fore a complete
list of available configuration keys refer to the [CernVM-FS Technical
Report][3].)

Example
-------

    "cvmfs" => {
      "client" => {
        "default_local" => {
          "cache_base" => "/opt/cvmfs/cache",
          "quota_limit" => -1,
          "max_ttl" => 60
        },
        "config_d" => {
          "repo1.devops.test" => {
            "server_url" => "http://lxcvmfs01.devops.test/cvmfs/repo1.devops.test",
            "http_proxy" => "DIRECT",
            "public_key" => "/etc/cvmfs/keys/repo1.devops.test.pub"
          },
          "repo2.devops.test" => {
            "server_url" => "http://lxcvmfs02.devops.test/cvmfs/repo2.devops.test",
            "public_key" => "/etc/cvmfs/keys/repo2.devops.test.pub",
            "quota_limit" => 20000
          }      
        }
      }
    }

[3]: http://cernvm.cern.ch/portal/filesystem/techinformation
