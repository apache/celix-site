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

CELIX_SRC_DIR="celix-src"
DOCS_DIR="source/docs"

RELEASE_VERSION=${1}
if [[ -z ${RELEASE_VERSION} ]]; then
    echo "Celix release not specified!"
    echo ""
    echo "Run with:"
    echo "  ./extract_celix_docs.sh <released version>"
    echo "    e.g."
    echo "  ./extract_celix_docs.sh \"2.1.0\""

    exit 1
fi

RELEASE_DIR="${DOCS_DIR}/${RELEASE_VERSION}"

if [[ ! -d "${RELEASE_DIR}" ]]; then
    mkdir -p "${RELEASE_DIR}"

    CELIX_DOCS_DIR="${RELEASE_DIR}/celix"

    for FILE_PATH in $(cd ${CELIX_SRC_DIR}; find . -name \*.md); do
        # Retrieve file information
        FILE_DIR="$(dirname ${FILE_PATH})"
        FILE_NAME="$(basename ${FILE_PATH})"

        # Copy markdown file to site destination
        mkdir -p ${CELIX_DOCS_DIR}/${FILE_DIR}
        cp -v ${CELIX_SRC_DIR}/${FILE_PATH} ${CELIX_DOCS_DIR}/${FILE_DIR}

        # Prepend markdown file with Hugo header
        DEST_FILE=${CELIX_DOCS_DIR}/${FILE_PATH}
        SECOND_LINE=$(head -n 2 ${DEST_FILE} | tail -n 1)

        if [[ "${SECOND_LINE}" != *"type: celix-doc"* ]]; then
            sed -i "1s;^;---\ntype: celix-doc\ntitle: ${FILE_NAME}\nversion: ${RELEASE_VERSION}\n---\n\n;" ${DEST_FILE}
        fi

        # Replace markdown links with HTML links
        sed -i "s/.md)/.html)/" ${DEST_FILE}
    done
else
    echo "Not extracting docs, output directory already exists!"
    exit 1
fi
