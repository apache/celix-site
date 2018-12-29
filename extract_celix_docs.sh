#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# A script to extract all markdown files from the Celix main repository
# and copies them to the path specified in ${site_doc_dir}

celix_src_dir=celix-src
site_doc_dir=source/docs/celix

rm -rf ${site_doc_dir}/*

for file in `cd ${celix_src_dir}; find . -name \*.md`
do
    file_dir="`dirname ${file}`"
    mkdir -p ${site_doc_dir}/${file_dir}
    cp -v ${celix_src_dir}/${file} ${site_doc_dir}/${file_dir}
done
