name "cvmfs_server_test"
description "Use to test the [cvmfs::server] recipe."
run_list( "recipe[cernvm-fs]" )
default_attributes(
  "cvmfs" => {
    "server" => {
      "repos" => [ 'alpha.devops.test' ]
    } 
  }
)
