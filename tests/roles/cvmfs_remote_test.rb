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
    },
    :remote_key => '
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpgIBAAKCAQEA2d97tAhXfim3E9WoHqz98wGxue4lzylk/AAs55lonR4wJmtt
    zvELw13N07iruzp7FqVepAjaTiasN+aX+3OsUSvmVVpPDJypBJvx7dlBrpFVrC4Z
    QD3Mxtw3n/G5EdA68zsm0f8rVo51G8RnoNxMicIHpQO+iqTXP6nQXmMmSOvwoB9w
    9IySn0XX7b/uAAv7QQah1HlGv0Ue7xuMk2rEPBwCLwh+KuRN1TtB7FhWQMcKHbTp
    JqmhJlKCsb1y9Ywp7bRC87XtXkKjApA7UuC4cXwHhRi8BA1E1/vXl7LQ5FGPQTtL
    9cQyZ4HuXdCJ1ZgaJ8tcGlyVN2eyU0EzI+2mfQIDAQABAoIBAQDI43OgUIC756LT
    OxHFFyUgx9Mj6R4bocNnSJIfCiiXlpo3Ep8xTLjX7so2CfTuscGE4/4bqb4AiVAK
    SyifxcyBG8VJtfdlXZ3Kji/Ia6ZQW9lu5SKLRXBne+4eIDfQ4Ps6ArSMtIc1TC1W
    6QXUIMzByJJb6NPr6oo+PUnPfgRy/sZFJCH6DofE/l9nFLy3IrpzHK/ewePv9weE
    naEdyHPOTXqFOiR/doiB/JHPxn3xpn60BaJt00BAIB8lkNdHEqOB6XY3bfKxQfv+
    JvGK4Rm+d24hyN8DloGBjZ6gHncz+lLjOEFTY81oGOVsBlzl3lHoZWixSm77RIYf
    83N0xJiBAoGBAPFC/FY2YfvmIYrGsr0HXKvf8djVpGacI/e0y+F+YXQNUSVbwxCR
    9yodJX2N0cK04co1vXf3HJEl3zRByByYbPpWvGJgB3O0PTciRw4sf34kWwjhvMUr
    GFxUYUdal3oQA2/J4hpEVN8UnYUjvUyaj8lqAts+rNj6Fpzr1/bt8hNZAoGBAOcu
    urjfJAXjvAPsc9Da/4ZTnOo6fX3cWfDVU474uvL8eZZNaeNdIPW53Bn2ALbcYtmt
    sEbBeyRbNeGJXDHYkFJtjHUWAsna333N3srBRSEFHwsa5idcgBioJIBaZsSK/cD8
    pclpBU8sKU5hffFhWaf3fIw3o1RwemiSZVcWAXvFAoGBAIqAcQoxKCkLISBhF0Ur
    T8kfw+A+LaX2ZzOR6CVofxu3dWkj96SwlxrnJpmga9YCL0j9durCwvSUsEF4rh+0
    ZYOFfZpgFIcY5rebBv2dEAfjaRt9M/hg2BhRHJNw71rUjJSFaja4GZ0DYbaIIOk0
    Je1z3XXt0h6x2390aUPJr9npAoGBAK9A+4g+kL5uQA/xZnMEMgWQyTm/kXaiXwR1
    k9ykroSZ5UqN8SHNbbkaZsK/fRcix0UhqKpa7pFHG/eX++5FsFLsfTgdsYt4g0iJ
    ksW98jvv9/KhN6zLMMiAXvt2jMWeYHO2k6+2D7JPVhj3S1R7ak4tDZv2abkPc5xm
    rrBwHDvJAoGBAKQgJ5EyoG2W1HptD+L4sZMUrE7eSyopQ2Ifi3i6TCIm1OlKtIUK
    GUSvgZDbsoJdG/kcTbU7ocVvD5K0iDorAA82iudGkQMiE91K03SYdbARE075KSmj
    jtFsUrYSo0xB5Q7nSpyO6H4YTKTuBeDb0E2g0Dugxqh+DKbAo10xBntx
    -----END RSA PRIVATE KEY-----
    '
  }
)
