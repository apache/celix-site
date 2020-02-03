---
type: celix-doc
title: Log Service
version: 2.1.0
---

<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at
   
    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

## Log Service

The Celix Log Service realizes an adapted implementation of the OSGi Compendium Log Service. This is a very simple implementation which only stores the log in memory. It can be combined with one of the available Log Writers to forward the buffered entries to e.g. stdout or syslog.

To ease the use of the Log Service, the [Log Helper](public/include/log_helper.h) can be used. It wraps and therefore simplifies the log service usage.

###### Properties
    LOGHELPER_ENABLE_STDOUT_FALLBACK      If set to any value and in case no Log Service is found the logs
                                          are still printed on stdout. 

###### CMake option
    BUILD_LOG_SERVICE=ON
