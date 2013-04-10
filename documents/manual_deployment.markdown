

The script `files/default/cvmfs-install` deploys a specific 
version of CernVM-FS [1] on the local node. Copy the script to
`/usr/local/src` and execute it like:

    » lsb_release -d
    Description:    Debian GNU/Linux 7.0 (wheezy)
    » /usr/local/src/cvmfs-install 2.1.8
    All build dependencies available.
    Working directory /usr/local/src/cvmfs-2.1.8
    Configure finished.
    Build finished.
    Installation finished.

## Server

This install Apache before creating a CernVM-FS file-system
repository:

    » apt-get install apache2
    » cvmfs_server mkfs repo.devops.test
    [...SNIP...]
    » cvmfs_server transaction
    » df -h -t aufs -t fuse
    Filesystem             Size  Used Avail Use% Mounted on
    /dev/fuse              4.0G   30K  4.0G   1% /var/spool/cvmfs/repo.devops.test/rdonly
    aufs_repo.devops.test   40G  1.4G   36G   4% /cvmfs/repo.devops.test
    » ls -1 /cvmfs/repo.devops.test
    new_repository

Details are described in the CernVM-FS Technical Report [2].
In order to update the repository (add/remove content) use
the `cvmfs_server` script:

    » cvmfs_server transaction
    » echo "Content" > /cvmfs/repo.devops.test/test.txt
    » cvmfs_server publish
    Processing changes...
    [add] /cvmfs/repo.devops.test/test.txt
    Waiting for upload of files before committing...
    Committing file catalogs...
    Exporting repository manifest
    Signing /var/spool/cvmfs/repo.devops.test/tmp/manifest
    Remounting newly created repository revision

Check if the repository is working:

    » curl -sL -w "%{http_code} %{url_effective}\\n" -o /dev/null http://localhost/cvmfs/repo.devops.test/.cvmfspublished 
    200 http://localhost/cvmfs/repo.devops.test/.cvmfspublished
    » cat /var/log/apache2/access.log
    ::1 - - [10/Apr/2013:14:14:34 +0200] "GET /cvmfs/repo.devops.test/.cvmfspublished HTTP/1.1" 200 690 "-" "curl/7.26.0"

Deploy the HTTP proxy:

    » apt-get install squid3 
    » grep devops /etc/squid3/squid.conf 
    acl devops src 10.1.1.0/24
    http_access allow devops
    » /etc/init.d/squid3 restart



## Clients

Make sure FUSE is correctly configured

    » chgrp fuse /dev/fuse
    » chmod 0660 /dev/fuse
    » adduser cvmfs fuse
    » cvmfs_config setup
    » grep ^user /etc/fuse.conf 
    user_allow_other # added by CernVM-FS
    » cvmfs_config chksetup
    OK

    » cat /etc/cvmfs/default.local 
    CVMFS_REPOSITORIES="repo.devops.test"
    CVMFS_CACHE_BASE=/var/cache/cvmfs
    » mkdir -p /var/cache/cvmfs
    » chown cvmfs:cvmfs /var/cache/cvmfs/
    » cat /etc/cvmfs/config.d/repo.devops.test.conf 
    CVMFS_SERVER_URL=http://lxdev01.devops.test/cvmfs/repo.devops.test
    CVMFS_HTTP_PROXY=DIRECT
    CVMFS_PUBLIC_KEY=/etc/cvmfs/keys/repo.devops.test.pub
    » cvmfs_config chksetup
    OK

    » mkdir -p /cvmfs/repo.devops.test
    » mount -t cvmfs repo.devops.test /cvmfs/repo.devops.test/
    CernVM-FS: running with credentials 999:999
    CernVM-FS: loading Fuse module... done
    CernVM-FS: mounted cvmfs on /cvmfs/repo.devops.test/
    » cvmfs_config probe
    Probing /cvmfs/repo.devops.test... OK


[1] [CernVM-FS Downloads][1]
[2] [CernVM-FS Technical Information][2]

[1]: http://cernvm.cern.ch/portal/filesystem
[2]: http://cernvm.cern.ch/portal/filesystem/techinformation
