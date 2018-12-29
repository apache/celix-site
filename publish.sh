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

# A script to build the Celix site (based on jekyll)

# specify source and site branches
SOURCE="master"
SITE="asf-site"

# Make sure the SOURCE branch is active
git checkout ${SOURCE} > /dev/null 2>&1

# Get the latest commit SHA in SOURCE branch
last_SHA=( $(git log -n 1 --pretty=format:"%H") )

# use last commit sha as temp folder name
tmp_dir=`mktemp -d`
out_dir=${tmp_dir}/content
mkdir -p ${out_dir}

# Build the Jekyll site  to our temporary folder
bundle exec jekyll build -d ${out_dir} > /dev/null 2>&1
if [ $? = 0 ]; then
  echo "Jekyll build successful"
else
  echo "Jekyll build failed"
  exit 1
fi

# Switch to the SITE branch
git checkout ${SITE} > /dev/null 2>&1

# Remove the current contents of the SITE branch and replace them with the contents of the temp folder
current_dir=${PWD}
rm -rf ${current_dir}/content
git rm -r --cached content/* > /dev/null 2>&1
mkdir -p ${current_dir}/content
cp -rT ${tmp_dir}/* ${current_dir}/content

# Commit the changes to the SITE branch
message="Updated site from ${SOURCE} (${last_SHA})"
git add -A
git commit -m "${message}" > /dev/null 2>&1

# Delete the temporary folder
rm -rf ${tmp_dir}

# Push the SOURCE to the server
git push -u origin ${SOURCE} > /dev/null 2>&1
if [ $? = 0 ]; then
 echo "Push ${SOURCE} successful"
else
 echo "Push ${SOURCE} failed"
fi

# Push the SITE to the server
git push -u origin ${SITE} > /dev/null 2>&1
if [ $? = 0 ]; then
  echo "Push ${SITE} successful"
else
  echo "Push ${SITE} failed"
fi

# Switch back to SOURCE branch
git checkout ${SOURCE} > /dev/null 2>&1
