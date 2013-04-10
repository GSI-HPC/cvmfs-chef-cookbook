name "cvmfs_server_test"
description "Use to test the [cvmfs::server] recipe."
run_list( "recipe[cvmfs]" )
default_attributes(
  "cvmfs" => {
    "version" => "2.1.8",
    "server" => {
      "repos" => [ 'hades.devops.test' ]
    } 
  }
)
