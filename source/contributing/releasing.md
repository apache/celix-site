---
layout: default
title: Releasing Process
---

# Releasing Apache Celix
{:.no_toc}

Note: This information is only of use to Apache Celix Release Managers!

Steps to follow:

* Will be replaced with the ToC, excluding a header
{:toc}

Interesting links:

* [Apache Release Guide](http://www.apache.org/dev/release.html)
* [Apache Release Signing](http://www.apache.org/dev/release-signing.html)
* [Apache RAT](http://creadur.apache.org/rat/apache-rat/index.html)
* [Apache OpenPGP HowTo](http://www.apache.org/dev/openpgp.html)

## Create signing KEYS

Each Release Manager must have his own signing keys. Information about and instruction for the generation 
of these keys can be found on the [Signing Releases page](http://www.apache.org/dev/release-signing.html#generate) 
and [How To OpenPGP](http://www.apache.org/dev/openpgp.html#generate-key). Be sure to follow the information 
provided on that site and its references.

The generated key can be uploaded to the [MIT PGP Public Key Server](http://pgp.mit.edu/).

Next, the public key signature must be added to the KEYS file. Again, read the [Signing Releases page](http://www.apache.org/dev/release-signing.html#keys-policy) 
for more information. This updated file needs to be uploaded to GIT, be sure to upload it to:

* [Apache Celix release development area KEYS](https://dist.apache.org/repos/dist/dev/celix/KEYS)
* [Apache Celix release distribution area KEYS](https://dist.apache.org/repos/dist/release/celix/KEYS)

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

Note: The DEFAULT_VERSION property is used as default version for new bundles and as such does not need to be updated when making a release.
{:.alert .alert-primary}

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

## Create GIT tag

After changing all files a tag for the new release must be made. Before doing so, make sure all changed files are committed.

The tag should be named like this: celix-X.Y.Z

To make a tag use the following command:

```bash
# To sign a tag using your GPG key, it is necessary to configure git with the key you want to use
# Configure git by issuing the following command, where E43F742E needs to be replaced with your key id
$ git config --global user.signingkey E43F742E

# Next thing to do is creating the tag
$ git tag -s rel/celix-X.Y.Z -m 'Celix release X.Y.Z'

# Next thing to do is pushing the tag to the remote
$ git push origin rel/celix-X.Y.Z
```

## Create, sign and publish artifacts

Since Celix only releases source artifacts, creating the artifact is simple and straightforward

```bash
# Create symbolic link so the archive has a directory with version information
$ ln -s celix celix-X.Y.Z

# Create GZip archive
$ tar -hczf celix-X.Y.Z.tar.gz celix-X.Y.Z

# The create symbolic link can be removed
$ celix celix-X.Y.Z
```

After creating the artifact, the file has to be signed. More information about signing can be found at 
[Release signing](http://www.apache.org/dev/release-signing.html).

```bash
# Generate MD5 checksum
$ md5 celix-X.Y.Z.tar.gz > celix-X.Y.Z.tar.gz.md5

# Generate SHA512 checksum
$ gpg --print-md SHA512 celix-X.Y.Z.tar.gz > celix-X.Y.Z.tar.gz.sha

# Generate ASCII signature
$ gpg --armor --output celix-X.Y.Z.tar.gz.asc --detach-sig celix-X.Y.Z.tar.gz
```

Copy the archive of the source to the [Apache Celix release development area](https://dist.apache.org/repos/dist/dev/celix/KEYS) (using SVN).

See the [Apache Release Guide](http://www.apache.org/dev/release.html#host-rc) for more information.

## Run the vote

Before a release is official a vote has to be held. More information on voting can be found on [Apache Voting Process](http://www.apache.org/foundation/voting.html).

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
http://www.apache.org/dev/release.html#approving-a-release

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

Note: Be sure to use the \[VOTE\] tag, this is used by the automated vote tracking system to keep track of outstanding vote threads.
{:.alert .alert-primary}

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

Note: Be sure to post the vote result with the same topic as the original message. Also prepend the subject 
with \[RESULT\]. This is, again, needed to be able to keep track of vote threads.
{:.alert .alert-primary}

## Roll out release artifacts

If the vote is passed successfully the release can be moved from the "dev" area to "release". The automated 
svnpubsub will move the artifact to the correct server for mirroring. Mirroring typically can take up to 24 hours.

Besides uploading the new release, the old release should be archived. Since archiving is already automated, 
it is only needed to delete the previous version from the release area. See the 
[Apache Release Guide](http://www.apache.org/dev/release.html#when-to-archive) for more information.

See the [Apache Release Guide](http://www.apache.org/dev/release.html#upload-ci) for more information.

After these 24 hours the release can be announced.

## Announce the release

Update website's News and Download sections to include the new release.

On the "Download" page, the old release can be replaced with the new one, there is no need to keep a link to archived versions. 
The "News" section can simply be extended with an additional entry.

Additionally it is a good idea to post a message to "announce@apache.org".

The following template must be used:

```text
To: announce@apache.org, dev@celix.apache.org
Subject: [ANNOUNCE] Apache Celix X.Y.Z released

The Apache Celix team is pleased to announce the release of Celix X.Y.Z.

Celix is an implementation of the OSGi specification adapted to C. It will follow the API as close as possible, but since the OSGi specification is written primarily for Java, there will be differences. An important aspect of the implementation is interoperability between Java and C. This interoperability is achieved by porting and implementing the Remote Services specification in Celix.

This new release focuses on .... {add additional information for this release}

The release is available here:
http://celix.apache.org/download.cgi

The full change log is available here:

We welcome your help and feedback. For more information on how to report problems, and to get involved, visit the project website at http://celix.apache.org/

The Apache Celix Team
```

Note: the email must be sent from an @apache.org address
{:.alert .alert-primary}
