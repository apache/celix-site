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

# A script to generate Doxygen documentation for the specified release

ROOT_DIR=$(pwd)
CELIX_SRC_DIR="celix-src"
DOCS_DIR="static/docs"

RELEASE_VERSION=${1}
if [[ -z ${RELEASE_VERSION} ]]; then
    echo "Celix release not specified!"
    echo ""
    echo "Run with:"
    echo "  ./generate_celix_doxygen.sh <released version>"
    echo "    e.g."
    echo "  ./generate_celix_doxygen.sh \"2.1.0\""

    exit 1
fi

RELEASE_DIR="${DOCS_DIR}/${RELEASE_VERSION}"
DOXYGEN_DOCS_DIR="${DOCS_DIR}/${RELEASE_VERSION}/html"

if [[ ! -d "${DOXYGEN_DOCS_DIR}" ]]; then
    mkdir -p ${RELEASE_DIR}

    # Set the PROJECT_NUMBER to the released version
    sed -i -E 's/^(PROJECT_NUMBER[[:blank:]]*=[[:blank:]]*).*/\1'"${RELEASE_VERSION}"'/' ${CELIX_SRC_DIR}/Doxyfile

    # Set output directory (used as environment variable in the Doxyfile)
    export DOXYGEN_OUTPUT_DIR="${ROOT_DIR}/${RELEASE_DIR}"

    # Generate documentation
    cd ${ROOT_DIR}/${CELIX_SRC_DIR}
    doxygen Doxyfile

    cd ${ROOT_DIR}
else
    echo "Not generating Doxygen documentation, Doxygen directory already exists for release!"
    exit 1
fi
