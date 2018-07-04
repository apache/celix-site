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
# Apache Celix website

The update celix website is still under construction and not yet live.

This is the website for [Apache Celix](https://celix.apache.org/), hosted at:

    https://celix.apache.org/

## Content Management System

The Celix website uses the Hugo content management system. See [Hugo](https://gohugo.io) for more info and for details how to install hugo

## Generate the website

### Copy documentation dir from celix repo

 - Run `git submodule init` and `git submodule update` to retreive the Celix sources
 - Run `./copy_docs_from_src_to_content.sh` to copy the documents director to the website content documentation section 

### Create doxygen documentation

TODO

### Generate the static website

To generate the static website run: `hugo`. The resulting public dir should contain a updated static website.
Or to just host it locally run: `hugo server -D`. The -D is provided to also host draft pages.

## Publish the website

TODO
