Description
-----------

The "cernvm-fs" cookbook deploys and configures [CernVM-FS][1] infrastructure.

_CernVM File System (CernVM-FS) is a read-only network file system based on HTTP and optimized to deliver software in a fast, scalable, and reliable way. Files and file meta-data are cached and downloaded on demand._

**Requirements**

* Chef version >= 12
* `apache2` cookbook
* [sys][2] cookbook (for package repository setup on Chef < 13)

**Platforms**

* Debian 7 (*Wheezy*)
* Debian 8 (*Jessie*)
* Debian 9 (*Stretch*)
* Debian 10 (*Buster*)

Usage
-----


CVMFS contains client-side software to mount a CVMFS “repository” as well as a web-server component to deliver files. A basic manual deployment and configuration with a repository server and a single client is described in [documents/manual.markdown][3]. 

This repository contains the script [`cvmfs-install`](files/default/cvmfs-install) to build CVMFS Debian packages that can be uploaded to a local package repository.
**These builds are deprecated**.
Instead the official CVMFS package repository is configured (cf. [recipe `apt_repository`](recipes/apt_repository.rb) and packages are installed from this repository.

Deployment and configuration of a CVMFS server is described in [documents/server.markdown][4].
**Only the CVMFS client setup is currently operational and tested.**

Mount CVMFS repositories on client nodes as explained in [documents/client.markdown][5].

The recipe `cernvm-fs::remote` helps to keep software build systems in sync with the corresponding CVMFS server publishing this software (read [documents/remote.markdown][6]).

License
-------

Copyright 2013-2023 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH

Authors:
  Matteo Dessalvi <m.dessalvi@gsi.de>
  Christopher Huhn <c.huhn@gsi.de>
  Walter Karig
  Dennis Klein <d.klein@gsi.de>
  Bastian Neuburger <b.neuburger@gsi.de>
  Matthias Pausch <m.pausch@gsi.de>
  Victor Penso <v.penso@gsi.de>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


[1]: http://cernvm.cern.ch/fs/
[2]: https://github.com/GSI-HPC/sys-chef-cookbook
[3]: documents/manual.markdown
[4]: documents/server.markdown
[5]: documents/client.markdown
[6]: documents/remote.markdown
