default[:cvmfs][:client][:default_local][:default_domain] = node['domain']
default[:cvmfs][:client][:default_local][:cache_base] = '/var/cache/cvmfs'
default[:cvmfs][:client][:default_local][:quota_limit] = 20000
default[:cvmfs][:client][:default_local][:max_ttl] = 30

default['cvmfs']['client']['domain_d'] = {}
default['cvmfs']['client']['config_d'] = {}
