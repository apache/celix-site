---
title: Releasing Process
---

# Releasing Apache Celix

Note: This information is only of use to Apache Celix Release Managers!

Steps to follow:

{{% tableofcontents %}}

Interesting links:

* [Apache Release Guide](https://www.apache.org/dev/release.html)
* [Apache Release Signing](https://www.apache.org/dev/release-signing.html)
* [Apache RAT](https://creadur.apache.org/rat/apache-rat/index.html)
* [Apache OpenPGP HowTo](https://www.apache.org/dev/openpgp.html)

## Create signing KEYS

Each Release Manager must have his own signing keys. Information about and instruction for the generation 
of these keys can be found on the [Signing Releases page](https://www.apache.org/dev/release-signing.html#generate) 
and [How To OpenPGP](https://www.apache.org/dev/openpgp.html#generate-key). Be sure to follow the information 
provided on that site and its references.

The generated key can be uploaded to the [MIT PGP Public Key Server](https://pgp.mit.edu/).

Next, the public key signature must be added to the [Celix KEYS file](https://downloads.apache.org/celix/KEYS).
Again, read the [Signing Releases page](https://www.apache.org/dev/release-signing.html#keys-policy) for more
information. This updated file needs to be uploaded to SVN at the following location:

* [Apache Celix release distribution area KEYS](https://dist.apache.org/repos/dist/release/celix/KEYS)

## Create release branch

A release will be prepared in a release branch. This branch is created from the `master` branch.

```bash
git checkout master
git checkout -b release-X.Y.Z
git push origin release-X.Y.Z
```

## Update release related files

For every release the related files must be updated. The following files are relevant:

* CHANGES
  - Add a list of fixed issues which can be created using JIRA.
* RELEASE_NOTES
  - Add additional notes regarding this release, eg known short comings.
* BUILDING
  - Even though the BUILDING file doesn't have any specific release information, it should be verified before making a release.
* NOTICE
  - If needed, add any new license related information to this file.

Besides this information, the version needs to be bumped. Even though every bundle has its own version, a release is made with one 
overall version. This version is defined in the top-level CMakeLists.txt file. Update the following pieces:

```C
set(CELIX_MAJOR "X")
set(CELIX_MINOR "Y")
set(CELIX_MICRO "Z")
```

<p class="alert alert-primary">Note: The DEFAULT_VERSION property is used as default version for new bundles and as 
such does not need to be updated when making a release.</p>

## Compile and test

Before creating a branch, be sure that the source compiles and tests run successfully. If there are any known shortcomings, 
make sure they are listed in the RELEASE_NOTES. Details for compiling and testing are available in the BUILDING file.

```bash
# Create a directory as sibling of the celix release directory
$ mkdir celix-build
$ cd celix-build

# Run CMake to generate the makefiles. Enable all BUILD options.
$ ccmake ../celix
$ make
$ make deploy
$ make test
```

Also verify that the provides examples work as expected. If needed ask other committers to test parts.

```bash
# Go to the deploy directory to see all examples
$ cd deploy

# Test the different examples, eg
$ cd hello_world
$ sh run.sh

# Depending on the example the output might be different. Most examples provide a shell to inspect the framework.
# To list the commands use the "help" command.
-> help
```

After verifying the build, run Apache RAT to check for any licensing problems. If Apache RAT is configured in the CMake build the "rat" target can be used to run the check.

```bash
# From the celix-build directory
# Run CMake to set the APACHE_RAT library (path to the JAR file).
$ ccmake ../celix
# Run RAT
$ make rat
```

Apache RAT should not raise any concerns, if there are, check the source files for a license header. If it is a false positive update 
the rat-excludes.txt file in the root of the project. Be sure it is a false positive! If in doubt, ask the mailing list! Third party 
licenses may need to be mentioned in the NOTICE file.

## Create, sign and publish artifacts

Since Celix only releases source artifacts, creating the artifact is simple and straightforward.
First verify that all changes are committed to the release branch and the branch is pushed to GitHub.

```bash
# Create symbolic link so the archive has a directory with version information
$ ln -s celix celix-X.Y.Z

# Create GZip archive
$ tar --exclude=".*" -hczf celix-X.Y.Z.tar.gz celix-X.Y.Z

# The create symbolic link can be removed
$ unlink celix-X.Y.Z
```

After creating the artifact, the file has to be signed. More information about signing can be found at 
[Release signing](https://infra.apache.org/release-signing.html).

```bash
# Generate SHA512 checksum
$ gpg --print-md SHA512 celix-X.Y.Z.tar.gz > celix-X.Y.Z.tar.gz.sha512

# Generate ASCII signature
$ gpg --armor --output celix-X.Y.Z.tar.gz.asc --detach-sig celix-X.Y.Z.tar.gz
```

Copy the archive of the source to the [Apache Celix release development area](https://dist.apache.org/repos/dist/dev/celix) (using SVN).

See the [Apache Release Guide](https://www.apache.org/legal/release-policy.html#host-rc) for more information.

## Run the vote

Before a release is official a vote has to be held. More information on voting can be found on [Apache Voting Process](https://www.apache.org/foundation/voting.html).

The first vote has to be done on the public [mailing list](/support/mailing-list.html) of the project. The following template must be used for this vote:

```text
To: dev@celix.apache.org
Subject: [VOTE] Release Celix version X.Y.Z

This is the release vote for Apache Celix, version X.Y.Z.

It fixes the following issues:

Source files:
https://dist.apache.org/repos/dist/dev/celix/celix-X.Y.Z/

The commit ID to be voted upon:
COMMIT ID

https://github.com/apache/celix/tree/COMMITID

Celix's keys can be found at:
https://dist.apache.org/repos/dist/dev/celix/KEYS

Information for voting on a release can be found at:
https://www.apache.org/legal/release-policy.html#approving-a-release

Please vote to approve this release:

[ ] +1 Approve the release
[ ] -1 Disapprove the release (please provide specific comments)

Note that an Apache release needs to be a Majority Approval (requires
at-least 3 binding +1 votes and more +1 votes than -1 votes).

If this release is approved I will promote it to an official release
(e.g. move from dist/dev to dist/release and tagging the release in git)

This vote will be open for at least 72 hours.
```

After this first vote the results must be posted to the "dev" list, see below for more information.

<p class="alert alert-primary">Note: Be sure to use the [VOTE] tag, this is used by the automated vote tracking 
system to keep track of outstanding vote threads.</p>

## Post the vote results
As mentioned before, after each vote the results must be posted to the corresponding list. This "Result" vote contains the number 
of votes made, including whether a vote is binding or not. For a successful vote the following template can be used.

```text
To: dev@celix.apache.org
Subject: [RESULT][VOTE] Release Celix version X.Y.Z

The vote has passed with the following result:

+1 Name of Approvers (binding)
+1 Name of Approvers (not binding)
...

The released artifact will be moved to the release area for mirroring. The
release branch will be merged with master and a 2.1.0 tag will be created.

After the mirroring period the news & downloads of the website will be
updated and the release will be announced.

Thanks for voting.
```

<p class="alert alert-primary">
    Note: Be sure to post the vote result with the same topic as the original message. Also prepend the subject with [RESULT]. 
    This is, again, needed to be able to keep track of vote threads.
</p>

## Vote Passed

If the vote is passed sucessfully the release branch can be merged to master, a release tag needs to be created, the release must be moved from the "dev" area to the "release" area 
and the release can be announced.

### Create Git tag and merge to master

After changing all files a tag for the new release must be made. Before doing so, make sure all changed files are committed.
A tag - named like rel/celix-X.Y.Z - needs to created and the release branch needs to be merged into master.

```bash
# To sign a tag using your GPG key, it is necessary to configure git with the key you want to use
# Configure git by issuing the following command, where E43F742E needs to be replaced with your key id
$ git config --global user.signingkey E43F742E

# Create the tag
$ git tag -s rel/celix-X.Y.Z -m 'Celix release X.Y.Z'

# Next thing to do is pushing the tag to the remote
$ git push origin rel/celix-X.Y.Z

$ git checkout master
$ git merge release-X.Y.Z
$ git push origin master
```

### Roll out release artifacts

When a release is moved from the "dev" area to "release" area. The automated 
svnpubsub will move the artifact to the correct server for mirroring. Mirroring typically can take up to 24 hours.

Besides uploading the new release, the old release should be archived. Since archiving is already automated, 
it is only needed to delete the previous version from the release area. See the 
[Apache Release Guide](https://www.apache.org/legal/release-policy.html#when-to-archive) for more information.

See the [Apache Release Guide](https://www.apache.org/legal/release-policy.html#upload-ci) for more information.

After these 24 hours the release can be announced.

### Publish release documentation

After the release is available and tagged, the matching Doxygen documentation needs to be published.
The following Jenkins job can be used for that:
https://ci-builds.apache.org/job/Celix/job/doxygen-docs/

* Click on 'Build with parameters'
* In the `VERSION` field, enter the release number, e.g. `2.2.1`
* Because release documentation will be generated, also check the `RELEASE` checkbox.
* Click on the `BUILD` button.

A build will be started after which a new directory will be created [here](https://nightlies.apache.org/celix/).

### Update the website

An important thing after the release has been created is updating the website.
The following needs to be updated:

* Update the `latestVersion` in the [config.toml]({{< site_src "config.toml" >}})
* If the release is a new minor or major version, the documentation for the previous version can be retained
by updating the [header.html]({{< site_src "layouts/partials/header.html" >}}) and adding the release number to the `Docs` dropdown.
* Update the `celix-src` submodule to the correct release tag
* Run the [extract_celix_docs.sh]({{< site_src "extract_celix_docs.sh" >}}) script to copy the markdown documentation within the Celix code base
to the website.
* Verify whether the documentation is correctly copied & otherwise make some minor tweaks.
* Create a `docs.md` file within the release documentation directory (example path: `source/docs/2.2.1/docs.md`, where 2.2.1 needs to be
  substituted with the actual released version). This file can be copied and updated from e.g. a previous release.
* Check-in the documentation and create a pull request to the [celix-site]({{< param "siteRepositoryUrl" >}}) repository for the Celix team to review.

Once the site is updated proceed with announcing the release.

### Announce the release

Additionally it is a good idea to post a message to "announce@apache.org".

The following template must be used:

```text
To: announce@apache.org, dev@celix.apache.org
Subject: [ANNOUNCE] Apache Celix X.Y.Z released

The Apache Celix team is pleased to announce the release of Celix X.Y.Z.

Celix is an implementation of the OSGi specification adapted to C. It will follow the API as close as possible, but since the OSGi specification is written primarily for Java, there will be differences. An important aspect of the implementation is interoperability between Java and C. This interoperability is achieved by porting and implementing the Remote Services specification in Celix.

This new release focuses on .... {add additional information for this release}

The release is available here:
https://celix.apache.org/download.cgi

The full change log is available here:

We welcome your help and feedback. For more information on how to report problems, and to get involved, visit the project website at https://celix.apache.org/

The Apache Celix Team
```

<p class="alert alert-primary">Note: the email must be sent from an @apache.org address</p>
