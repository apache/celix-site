---
title: Source code and builds
---

# Source code and builds

{{% tableofcontents %}}

## Celix source repository

Besides the archives offered on the [download](/download.cgi) page, Celix uses a source code repository hosted on both 
Apache and GitHub environments for development. This repository is mirrored and is our one-and-only development repository. 

With [Git](https://git-scm.com/) installed, obtaining a working copy of the Celix codebase is as simple as

```
> git clone https://gitbox.apache.org/repos/asf/celix.git
```

or from GitHub

```
> git clone https://github.com/apache/celix.git
```

For more about using version control systems at Apache, see the ASF's
[Source Code Repositories](https://www.apache.org/dev/#version-control) page.

### Building and using Celix
 
How to build and use Celix is described within our 'Docs' section which can be found [here](/docs/{{< param "latestVersion" >}}/docs.html) for the latest release.

## Website source repository

The website Celix provides - https://celix.apache.org - is mostly written in Markdown and build using [Hugo](https://gohugo.io/).
The website source code repository can be obtained using

```
> git clone https://gitbox.apache.org/repos/asf/celix-site.git
```

or from GitHub

```
> git clone https://github.com/apache/celix-site.git
```

### Building the website

To generate the static website, execute `hugo` to generate and serve the website on `localhost:1313`.

During development, it may be useful to run an incremental build. For this to work, execute `hugo server -D` to 
continuously generate and serve the website on `localhost:1313`.

After making some changes and being ready to submit the work a pull request against the `celix-site` repository can be 
created. The celix-site repository has [Netlify](https://www.netlify.com) enabled meaning a bot will comment with a link 
to preview the actual site. For example the following pull request: [https://github.com/apache/celix-site/pull/7](https://github.com/apache/celix-site/pull/7#issuecomment-510947939). 
Per pull request a preview will be generated so new contributors are able to preview the generated site very quickly and 
reviewing new contributions will therefore be easier as well.

<a href="https://www.netlify.com">
  <img src="https://www.netlify.com/img/global/badges/netlify-color-accent.svg"/>
</a>

<br/>
<br/>

After merging the change back to the `master` branch, [Jenkins](https://builds.apache.org/job/celix-site/) 
will be triggered for deploying the site to https://celix.apache.org.
