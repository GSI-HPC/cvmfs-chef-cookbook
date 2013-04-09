name "cvmfs_server_test"
description "Use to test the [cvmfs::server] recipe."
run_list( "recipe[cvmfs]" )
default_attributes(
  "cvmfs" => {
    "server" => {
      "version" => "2.1.8",
      "proxy" => {
        "access" => {
          "devops" => "10.1.1.0/24"
        }        
      }
    } 
  }
)
