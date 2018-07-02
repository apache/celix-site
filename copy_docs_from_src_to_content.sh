#!/bin/sh

src_doc_dir=celix-src/documents
site_doc_dir=content/documents

for file in `cd ${src_doc_dir}; find . -name \*.md`
do
    dest=`dirname ${file}`
    mkdir -p ${site_doc_dir}/${dest}
    cp -v ${src_doc_dir}/${file} ${site_doc_dir}/${dest}/index.md
done
