#!/bin/sh

src_doc_dir=celix-src/documents
site_doc_dir=content/documentation

for file in `cd ${src_doc_dir}; find . -name \*.md`
do
    dest="`dirname ${file}`.md"
    dest_dir="`dirname ${dest}`"
    mkdir -p ${site_doc_dir}/${dest_dir}
    cp -v ${src_doc_dir}/${file} ${site_doc_dir}/${dest}
done
