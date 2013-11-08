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
    },
    "keys" => {
      "alpha.devops.test.pub" => "
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv5vG3NPejVo0KQdgJifN
        /pbWI0q0ujRw2i5UUStNHDzYWXqe6n61JZtnMnbmhD4K6qqHMg8a2G78Hlr5/mQt
        FqnNxbGjNwYivPSXxd8ha1ys6j8CuAvfRHwOvSkR7cUWt4sP38IIRfoXwunTRpGr
        dCJ+ILR7ctnFcu7IyBNBE5x040dbm4pTtWe0HinN8oUsSFNLSPfeEOKzdKVi0O66
        lI65KC8hlRfPz+a3ISzSljKjB0SlG28OyhlIW2oEqZfFCQj3kUnmiUy7TxXDp2iG
        m3ur+moaWKL6TIDaNF8vlx0AdW4yRqX22GSToFQ2AfKiUifij8Vk3qEQE6YvQKrm
        JQIDAQAB
        -----END PUBLIC KEY-----
      "
    }
  }
)
