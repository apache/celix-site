# Apache Celix website

This is the website for [Apache Celix](https://celix.apache.org/), hosted at:

    https://celix.apache.org/

### Repository Structure

This repository contains:

1. `src/`: the source of the site, including markdown files containing the bulk of the content
1. `site/`: html generated from the markdown (which is what is actually hosted on the website)
1. `celix/`: dummy celix sourcecode

# Server build instructions
### building
```bash
cd path/to/build.py
./build.py
```
A test-server will run on [localhost:8000](https://localhost:8000/)
### installing 
1. install [python](https://www.python.org/)(tested versions: 2.7.10)
1. install [markdown2](https://github.com/trentm/python-markdown2/blob/master/README.md#install)
