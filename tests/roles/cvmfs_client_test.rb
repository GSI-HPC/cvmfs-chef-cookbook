name "cvmfs_client_test"
description "Use to test the [cvmfs::client] recipe."
run_list( "recipe[cvmfs]" )
default_attributes(
  "cvmfs" => {
    "version" => "2.1.8",
    "client" => {
      "config_d" => {
        "hades.devops.test" => {
          "server_url" => "http://lxfs01.devops.test/cvmfs/@org@",
          "http_proxy" => "DIRECT",
          "public_key" => "/etc/cvmfs/keys/hades.devops.test.pub"
        },
        "apollo.devops.test" => {
          "server_url" => "http://lxfs02.devops.test/cvmfs/@org@",
          "public_key" => "/etc/cvmfs/keys/apollo.devops.test.pub"
        }      
      }  
    }
  }
)
