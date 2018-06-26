---
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
title: Releasing
---
# Releasing Apache Celix

Note: This information is only of use to Apache Celix Release Managers!

Steps to follow:

  - Create signing KEYs
  - Update release related files
  - Compile and test
  - Create SVN tag
  - Create, sign and publish artefacts
  - Run the vote
  - Post the vote results
  - Roll out the release artefacts
  - Announce the release

Interesting links:

 - [Apache Release Guide](http://www.apache.org/dev/release.html)
 - [Apache Release Signing](http://www.apache.org/dev/release-signing.html)
 - [Apache RAT](http://creadur.apache.org/rat/apache-rat/index.html)
 - [Apache OpenPGP Howto](http://www.apache.org/dev/openpgp.html)

## Create signing KEYs
Each Release Manager must have his own signing keys. Information about and instruction for the generation of these keys can be found on the
[Signing Releases page](http://www.apache.org/dev/release-signing.html#generate) and [How To OpenPGP](http://www.apache.org/dev/openpgp.html#generate-key). Be sure to follow the information provided on that site and its references.

The generated key can be uploaded to the [MIT PGP Public Key Server](http://pgp.mit.edu).

Next, the public key signature must be added to the KEYS file. Again, read the [Signing Releases page](http://www.apache.org/dev/release-signing.html#keys-policy)
for more information. This updated file needs to be uploaded to SVN, be sure to upload it to:

  - [Apache Celix release development area KEYS](https://dist.apache.org/repos/dist/dev/incubator/celix/KEYS)
  - [Apache Celix release distribution area KEYS](https://dist.apache.org/repos/dist/release/incubator/celix/KEYS)

## Update release related files
For every release the related files must be updated. The following files are relevant:

  - CHANGES.md

     Add a list of fixed issues which can be created using Jira.

  - RELEASE_NOTES

     Add additional notes regarding this release, eg known short comings.

  - BUILDING

     Even though the BUILDING file doesn't have any specific release information, it should be verified before making a release.  

  - NOTICE

     If needed, add any new license related information to this file.
  
Besides this information, the version needs to be bumped. Even though every bundle has its own version, a release is made with one overall version. This version
is defined in the top-level CMakeLists.txt file.
Update the following pieces:

    SET(CELIX_MAJOR "X")
    SET(CELIX_MINOR "Y")
    SET(CELIX_MICRO "Z")

Note: The DEFAULT_VERSION property is used as default version for new bundles and as such does not need to be updated when making a release.
  
## Compile and test
Before creating a branch, be sure that the source compiles and tests run successfully. If there are any known shortcomings, make sure they are listed in the 
RELEASE_NOTES. Details for compiling and testing are available in the BUILDING file.

Also verify that the provides examples work as expected. If needed ask other committers to test parts.

After verifying the build, run Apache RAT to check for any licensing problems. If Apache RAT is configured in the CMake build the "rat" target can be used to run
the check.

    // From the celix-build directory
    // Run CMake to set the APACHE_RAT library (path to the JAR file).
    > ccmake ../celix
    // Configure location of the apache-rat jar
    > make rat

Apache RAT should not raise any concers, if there are, check the source files for 
a license header. If it is a false positive update the rat-excludes.txt file in the root of the project. Be sure it is a false positive! If in doubt, ask the 
mailing list! Third party licenses may need to be mentioned in the NOTICE file.

## Git commit ID
After changing all files a git commit ID can be used for the new release must be made. Before doing so, make sure all changed files are committed.

Note: Make sure there are no new changes made on release branch while working on the release.

## Create, sign and publish artefacts
Since Celix only releases source artefacts, creating the artefact is simple and straightforward

    // Create a release artefact using git archive
    > git archive --format tar.gz --prefix celix-<release number>/ <commit ID> > celix-<release number>.tar.gz

After creating the artefact, the file has to be signed. More information about signing can be found at (http://www.apache.org/dev/release-signing.html).

    // Generate MD5 checksum
    > md5 celix-X.Y.Z.tar.gz > celix-X.Y.Z.tar.gz.md5
    // Generate SHA512 checksum
    > gpg --print-md SHA512 celix-X.Y.Z.tar.gz > celix-X.Y.Z.tar.gz.sha
    // Generate ASCII signature
    > gpg --armor --output celix-X.Y.Z.tar.gz.asc --detach-sig celix-X.Y.Z.tar.gz

Copy the archive of the source to the [Apache Celix release development area](https://dist.apache.org/repos/dist/dev/celix) (using SVN).

See the [Apache Release Guide](http://www.apache.org/dev/release.html#host-rc) for more information.

## Run the vote
Before a release is official a vote has to be held. More information on voting can be found on [Apache Voting Process](http://www.apache.org/foundation/voting.html).

The first vote has to be done on the public mailinglist of the project itself (dev@celix.apache.org). The following template must be used for this vote:

================================================================================================================
> To: dev@celix.apache.org  
> Subject: [VOTE] Release Celix version X.Y.Z

> This is the release vote for Apache Celix, version X.Y.Z.

> Source files:  
> https://dist.apache.org/repos/dist/dev/celix/celix-X.Y.Z/

> The commit ID to be voted upon:  
> <commit ID>
> https://github.com/apache/celix/tree/<commit ID>

> Celix's keys can be found at:  
> https://dist.apache.org/repos/dist/dev/incubator/celix/KEYS

> Information for voting on a release can be found at http://www.apache.org/dev/release.html#approving-a-release

> Please vote to approve this release:

> [ ] +1 Approve the release  
> [ ] -1 Disapprove the release (please provide specific comments)

> This vote will be open for at least 72 hours.

================================================================================================================

After this first vote the results must be posted to the "dev" list, see below for more information.

================================================================================================================

Note: Be sure to use the [VOTE] tag, this is used by the automated vote tracking system to keep track of outstanding vote threads.

## Post the vote results
As mentioned before, after each vote the results must be posted to the corresponding list. This "Result" vote contains the number of votes made, including 
wether a vote is binding or not. For a successful vote the following template can be used.

================================================================================================================
> To: dev@celix.apache.org  
> Subject: [RESULT][VOTE] Release Celix version X.Y.Z

> The vote has passed with the following result:

> +1 Name of Approver (apache ID) (binding|not binding)  
> +1 Name of Approver (apache ID) (binding|not binding)  
> ...

> {include additional details if needed}

> The released artifact will be moved to the release area for mirroring. After the mirroring period the release will be announced.

> Thanks for voting.

================================================================================================================

Note: Be sure to post the vote result with the same topic as the original message. Also prepend the subject with [RESULT]. This is, again, needed to be able to keep track
of vote threads. 

## Roll out release artefacts
If the vote is passed successfully the release can be moved from the "dev" area to "release". The automated svnpubsub will move the artifact to the correct 
server for mirroring. Mirroring typically can take up to 24 hours.

Besides uploading the new release, the old release should be archived. Since archiving is already automated, it is only needed to delete the previous version from the release
area. See the [Apache Release Guide](http://www.apache.org/dev/release.html#when-to-archive) for more information.

See the [Apache Release Guide](http://www.apache.org/dev/release.html#upload-ci) for more information.

After these 24 hours the release can be announced.

## Announce the release
Update website's [News](http://celix.apache.org/index.html) and [Download](http://celix.apache.org/download.html) sections to include the new release.

On the "Download" page, the old release can be replaced with the new one, there is no need to keep a link to archived versions. The "News" section can simply be extended
with an additional entry.

Additionally it is a good idea to post a message to "announce@apache.org" and "dev@celix.apache.org". (note: the from address must be a ...@apache.org address).

The following template must be used:

================================================================================================================
> To: announce@apache.org, dev@celix.apache.org  
> Subject: [ANNOUNCE] Apache Celix X.Y.Z released

> The Apache Celix team is pleased to announce the release of Celix X.Y.Z.

> Celix is an implementation of the OSGi specification adapted to C. It will follow the API 
> as close as possible, but since the OSGi specification is written primarily for Java, there 
> will be differences. An important aspect of the implementation is interoperability between 
> Java and C. This interoperability is achieved by porting and implementing the Remote 
> Services specification in Celix.

> This new release focusses on .... {add additional information for this release}

> The release is available here:  
> http://celix.apache.org/download.cgi

> We welcome your help and feedback. For more information on how to report problems, 
> and to get involved, visit the project website at http://celix.apache.org/

> The Apache Celix Team

================================================================================================================
