Description
-----------

The "cernvm-fs" cookbook deploys and configures [CernVM-FS][1] (CVMFS) infrastructure.

_CernVM File System (CernVM-FS) is a network file system based on HTTP and optimized to deliver software in a fast, scalable, and reliable way. Files and file meta-data are cached and downloaded on demand. Thereby the CernVM-FS decouples the life cycle management of the application software releases from the operating system._

**Requirements**

* Chef version >=10.12
* [sys][2] cookbook > 0.10.0

**Platforms**

* Debian 7 (Wheezy)
* No other platforms supported yet.

Usage
-----

Read the “[Manual Deployment][3]” guide for a very simple example. Deployment and configuration of CVMFS servers is described in the [Server Guide][4]. Mount CVMFS repositories on client nodes as explained in the [Client Guide][5].

License
-------

Author: Victor Penso (v.penso@gsi.de)

Copyright 2013, GSI, HPC Department

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


[1]: http://cernvm.cern.ch/portal/filesystem
[2]: https://github.com/GSI-HPC/sys-chef-cookbook
[3]: documents/manual.markdown
[4]: documents/server.makrdown
[5]: documents/client.makrdown
