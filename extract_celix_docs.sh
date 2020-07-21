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
        DEST_FILE="${CELIX_DOCS_DIR}/${FILE_PATH}"
        FIRST_LINE="$(head -n 1 ${DEST_FILE})"

        if [[ "${FIRST_LINE}" != *"---"* ]]; then
            # No header found, probably a 3rd party file
            # Prepend header to file
            sed -i "1s;^;---\ntitle: ${FILE_NAME}\ntype: celix-doc\nversion: ${RELEASE_VERSION}\n---\n\n;" "${DEST_FILE}"
        else
            # Get everything between the --- at the beginning of the file
            # Also replace line-breaks with '\n' for multiline replacements
            header=$(awk 'BEGIN{ORS="\\n";}/---/{++c;next} c==1' ${DEST_FILE})

            # Strip final '\n' character
            header=${header/%\\n/}

            # Escape forward slashes for the replacement command
            original_header="${header////\\/}"
            new_header="${original_header}"

            if [[ "${new_header}" != *"type:"* ]]; then
                new_header="${new_header}\ntype: celix-doc"
            fi

            # Append the version
            new_header="${new_header}\nversion: ${RELEASE_VERSION}"

            # Only replace header if there are any differences
            if [[ "${original_header}" != "${new_header}" ]]; then
                # Use perl instead of sed because of sed its incredibly vague syntax for multi-line replacements
                # See: https://unix.stackexchange.com/a/26290
                perl -0777 -i -pe "s/${original_header}/${new_header}/" "${DEST_FILE}"
            fi
        fi

        # Replace markdown links with HTML links
        sed -i "s/.md)/.html)/" "${DEST_FILE}"
    done
else
    echo "Not extracting docs, output directory already exists!"
    exit 1
fi
