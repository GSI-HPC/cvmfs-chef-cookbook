Description
-----------

The "cernvm-fs" cookbook deploys and configures [CernVM-FS][1] infrastructure.

_CernVM File System (CernVM-FS) is a read-only network file system based on HTTP and optimized to deliver software in a fast, scalable, and reliable way. Files and file meta-data are cached and downloaded on demand._

**Requirements**

* Chef version >=10.12
* [sys][2] cookbook > 0.10.0

**Platforms**

* Debian 7 (Wheezy)
* No other platforms supported yet.

Usage
-----

CVMFS contains client-side software to mount a CVMFS “repository” as well as a web-server component to deliver files. A basic manual deployment and configuration with a repository server and a single client is described in [documents/manual.markdown][3]. 

Build CVMFS Debian packages with the [cvmfs-install](files/default/cvmfs-install) script, and upload the deb-files to a local package repository. Deployment and configuration of a CVMFS server is described in [documents/server.markdown][4]. Mount CVMFS repositories on client nodes as explained in [documents.client.markdown][5]. 

The recipe `cernvm-fs::remote` helps to keep software build systems in sync with the corresponding CVMFS server publishing this software (read [documents/remote.markdown][6]).

License
-------

Author: Victor Penso

Copyright 2013, GSI, HPC Department

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


[1]: http://cernvm.cern.ch/portal/filesystem
[2]: https://github.com/GSI-HPC/sys-chef-cookbook
[3]: documents/manual.markdown
[4]: documents/server.markdown
[5]: documents/client.markdown
[6]: documents/remote.markdown

