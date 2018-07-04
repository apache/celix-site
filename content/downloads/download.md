---
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
title: Download
---
# Download Celix

Celix is an implementation of the OSGi specification adapted to C.


## Releases

Apache Celix only releases source distributions, information about building and running van be found inside the release tarball.

### Mirrors

The currently selected mirror is **[preferred]**. If you encounter a problem with this mirror, please select another mirror. If all mirrors are failing, there are *backup* 
mirrors (at the end of the mirrors list) that should be available. 
<form action="[location]" method="get" id="SelectMirror">Other mirrors:
    <select name="Preferred">
        [if-any http] [for http]<option value="[http]">[http]</option>[end] [end] 
        [if-any ftp] [for ftp]<option value="[ftp]">[ftp]</option>[end] [end] 
        [if-any backup] [for backup]<option value="[backup]">[backup] (backup)</option>[end] [end]
    </select>
    <input type="submit" value="Change"></input>
</form>

You may also consult the [complete list of mirrors](http://www.apache.org/mirrors/).

### Downloads

- Source: [celix-2.0.0.tar.gz]([preferred]/celix/celix-2.0.0/celix-2.0.0.tar.gz)
[PGP](http://www.apache.org/dist/celix/celix-2.0.0/celix-2.0.0.tar.gz.asc)
[MD5](http://www.apache.org/dist/celix/celix-2.0.0/celix-2.0.0.tar.gz.md5)
[SHA1](http://www.apache.org/dist/celix/celix-2.0.0/celix-2.0.0.tar.gz.sha)
