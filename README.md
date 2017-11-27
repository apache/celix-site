# Apache Celix website

This is the website for [Apache Celix](https://celix.apache.org/), hosted at:

    https://celix.apache.org/

### Repository Structure

This repository contains:

1. `src/`: the source of the site, including markdown files containing the bulk of the content
1. `build.py`: generates `site/` directory, which contains the celix website
1. `celix/`: the celix sourcecode

### Cloning this repo
This repository can be cloned as usual. Because the website is using the offical celix repository as submodule, some extra commands need to be executed. Run this after cloning and the 'celix' directory will be initialized:
```bash
$ git submodule init
$ git submodule update
```

More about submodules can be found [here](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

# Server build instructions

### building
```bash
cd path/to/build.py
./build.py
```
A test-server will run on [localhost:8000](https://localhost:8000/)

### installing 
1. install [python](https://www.python.org/) (tested versions: 2.7.10)
1. install [markdown2](https://github.com/trentm/python-markdown2/blob/master/README.md#install)
