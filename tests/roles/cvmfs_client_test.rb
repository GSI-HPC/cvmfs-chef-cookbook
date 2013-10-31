name "cvmfs_client_test"
description "Use to test the [cvmfs::client] recipe."
run_list( "recipe[cernvm-fs]" )
default_attributes(
  "cvmfs" => {
    "client" => {
      "config_d" => {
        "alpha.devops.test" => {
          "server_url" => "http://lxfs01.devops.test/cvmfs/@org@",
          "http_proxy" => "DIRECT",
          "public_key" => "/etc/cvmfs/keys/alpha.devops.test.pub"
        },
        "betta.devops.test" => {
          "server_url" => "http://lxfs02.devops.test/cvmfs/@org@",
          "public_key" => "/etc/cvmfs/keys/betta.devops.test.pub"
        }      
      }  
    }
  }
)
