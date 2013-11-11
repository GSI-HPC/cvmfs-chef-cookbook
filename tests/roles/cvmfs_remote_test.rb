name "cvmfs_remote_test"
description "Use to test the [cvmfs::remote] recipe."
run_list( 
  "recipe[sys::accounts]",
  "recipe[cernvm-fs::remote]" 
)
default_attributes(
  :sys => {
    :accounts => {
      :skywalker => {},
      :solo => {},
      :lea => {},
      :joda => {}
    }
  },
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
    }
  }
)
