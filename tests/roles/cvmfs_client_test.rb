name "cvmfs_client_test"
description "Use to test the [cvmfs::client] recipe."
run_list( "recipe[cvmfs]" )
default_attributes(
  "cvmfs" => {
    "version" => "2.1.8"
  }
)
