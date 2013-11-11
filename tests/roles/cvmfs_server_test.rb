name "cvmfs_server_test"
description "Use to test the [cvmfs::server] recipe."
run_list( 
  "recipe[sys::ssh]",
  "recipe[cernvm-fs]" 
)
default_attributes(
  :sys => {
    :ssh => {
      :authorize => {
        'cvmfs' => {
          :keys => [ 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZ33u0CFd+KbcT1agerP3zAbG57iXPKWT8ACznmWidHjAma23O8QvDXc3TuKu7OnsWpV6kCNpOJqw35pf7c6xRK+ZVWk8MnKkEm/Ht2UGukVWsLhlAPczG3Def8bkR0DrzOybR/ytWjnUbxGeg3EyJwgelA76KpNc/qdBeYyZI6/CgH3D0jJKfRdftv+4AC/tBBqHUeUa/RR7vG4yTasQ8HAIvCH4q5E3VO0HsWFZAxwodtOkmqaEmUoKxvXL1jCnttELzte1eQqMCkDtS4LhxfAeFGLwEDUTX+9eXstDkUY9BO0v1xDJnge5d0InVmBony1waXJU3Z7JTQTMj7aZ9' ]
        }
      }
    }
  },
  :cvmfs => {
    :server => {
      :repos => [ 'alpha.devops.test' ]
    } 
  }
)
