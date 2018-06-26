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
title: Board Reports
---
# Board Reports

To monitor incubator project, the Apache Software Foundation board holds monthly meetings.
For these meetings a board report must be delivered to the Incubator PMC.

On this page the reports for Celix are shown.

## [2013-10](http://wiki.apache.org/incubator/October2013)

= Celix =

Celix is an OSGi like implementation in C with a distinct focus on interoperability between Java and C.

Celix has been incubating since 2010-11-02.

Three most important issues to address in the move towards graduation:

  1. Grow the community
  2. Find more committers
  3. Publish a new release

Any issues that the Incubator PMC (IPMC) or ASF Board wish/need to be
aware of?

None

How has the community developed since the last report?

Several new people are working on additional code for the project. One person is working on a GSoC project, someone else is working on a new remote services protocol and is actively communicating over the list and using jira to post patches. Overall this is an increase in activity. 
The Native-OSGi project is still progressing, but rather slow. So there isn't anything new on that end. Celix is still the reference implementation, so I still expect this to be a great drive for Celix, for the code as well as the committers.

How has the project developed since the last report?

As mentioned above, a student is working on a GSoC project and has implemented an Event Admin which will be included in Celix. Also a additional Remote Services implementation based on shared memory is being made.
Work for a new release is still ongoing, the focus is slightly changing, one of the main users has requested a release. Since they don't use Win32, Win32 support can be stripped from the release plan and postponed to a later release.

Date of last release: 

  * 16-12-2012

When were the last committers or PMC members elected?

  * 2013-01-07 Roman Shaposhnik joins as a mentor.
  * 2012-03-20 Pepijn elected as committer.

## [2013-07](http://wiki.apache.org/incubator/July2013)

= Celix =

Celix is an OSGi like implementation in C with a distinct focus on interoperability between Java and C.

Celix has been incubating since 2010-11-02.

Three most important issues to address in the move towards graduation:

  1. Grow the community
  2. Find more committers
  3. ...

Any issues that the Incubator PMC (IPMC) or ASF Board wish/need to be aware of?
None.


How has the community developed since the last report?
Activity on the mailing list is still a bit slow, but there is still progress. But more importantly, the Native-OSGi effort has taken a few big steps. The most important one is the publication of an RFP at the OSGi Alliance [ 1 ]. The purpose of this RFP is to standardise OSGi for native (C and C++) languages. After the RFP is finalised work will be started on a RFC, this will be done in conjunction with writing a reference implementation. For this purpose Apache Celix will be used. This also means that C++ will be introduced in the Celix project. Most likely large parts of C++ code will be donated by 2 participants of the Native-OSGi project. This gives us a great opportunity to add extra committers and increase the diversity of Celix.

How has the project developed since the last report?
As mentioned above, to be able to write a reference implementation for Native-OSGi the scope of Celix will be extended to also include C++. Details of this extension still need to be worked out. But for continuity the current (C) code base will (for now) remain the same. So any work related to Native-OSGi will (for now) be done independently from the current implementation.
Also work is underway to make a second release. Whereas the first release focused primarily on the releasing itself, this second release will focus on the actual implementation. Important points are:

  * API consistency
  * Win32 support
  * APR usage

More details can be found in [ 2 ]

A (Mini) Hackathon for Apache Celix was organised at June the 30th. There where 4 people present on the hackathon (2 committers) and focus for the hackathon was the remote services implementation. The hackathon was received well and we like to do this more often to encourage community growth of Apache Celix.

Apache Celix is now also involved the Google Summer of Code for 2013. Erik Jansman is doing a project on the Event Admin for Apache Celix and Pepijn Noltes is mentoring him. The idea is to discuss the result on the mailing list. This is a new experience for Apache Celix and we hope that helps the community and also provide technical progress.

Date of last release: 
16-12-2012

[ 1 ] https://www.osgi.org/bugzilla/show_bug.cgi?id=165

[ 2 ] http://incubator.markmail.org/thread/fza43iypjutcw2rm

## [2013-04](http://wiki.apache.org/incubator/April2013)

= Celix =

Celix is an OSGi like implementation in C with a distinct focus on interoperability between Java and C.

Celix has been incubating since 2010-11-02.

Three most important issues to address in the move towards graduation:

  1. Grow a community
  2. Find more committers
  3. ..

Celix is maintained by 2 committers and a small group of users. Questions to the mailing list are (most of the time) answered quickly. We are also trying to give talks on Celix or related stuff on conferences.
We see and recognise the problem of the small community, but are also confident that Celix and its community will grow. 

Any issues that the Incubator PMC (IPMC) or ASF Board wish/need to be aware of?
None.

How has the community developed since the last report?
There is no active growth, but there is currently one students doing his intership with Apache Celix and we are trying hoping to get some projects in the Google Summer of Code 2013. We hope that this will lead in more activity on the mailing-list and hopefully to extra committers.

How has the project developed since the last report?
Technically progress has been slow the last months. There was a hackaton organized for remote services in Java [ 1 ], which although not directly related to Apache Celix, should eventually work together with the Apache Celix and as result the committers of Apache Celix where present. We also expect an increase in contributions the coming months because of the student intership / GSoC activities.

[ 1 ] http://lists.amdatu.org/pipermail/dev/2013-March/000020.html

## [2013-01](http://wiki.apache.org/incubator/January2013)

= Celix =

Celix is an OSGi like implementation in C with a distinct focus on interoperability between Java and C.

Celix has been incubating since 2010-11-02.

Three most important issues to address in the move towards graduation:

  1. Grow a community
  2. Find more committers
  3. ..

Celix is maintained by 2 committers and a small group of users. Questions to the mailing list are (most of the time) answered quickly. We are also trying to give talks on Celix or related stuff on conferences.
We see and recognise the problem of the small community, but are also confident that Celix and its community will grow. Especially the Native-OSGi work might be important for this (see below).

Any issues that the Incubator PMC (IPMC) or ASF Board wish/need to be aware of?
None.

How has the community developed since the last report?

There is no active growth, but in the past few months talks have been given on Native-OSGi. Native-OSGi is an effort to standardise C/C++ implementations of OSGi. The goal of this is to be able to reuse bundles from other OSGi like implementations. Also working together might attract more users/committers. The talks are attended by a good group of people, and reactions are positive.

How has the project developed since the last report?

A first release has been made. After struggling with several problems, consensus has been reached to solve these in a next release.
On a technical note, Celix now also compiles and runs on Win32 platforms.

## [2012-10](http://wiki.apache.org/incubator/October2012)

= Celix =

Celix is an implementation of the OSGi Specification in C. 

Celix entered incubation on November 2, 2010. 

Over the last months we have focused on creating a first release for Celix.
As is mentioned in the graduation plan [1] we hope that a release will create
more community.
We have prepared the code base and website for release and we are very close to making a release.

The previous report [2] mentioned that we are working on a "Native-OSGi", which could attract more community.
This discussion continued in Juli on the mailling, but got quiet after that. There will be a talk about Native-OSGi for ApacheCon EU and EclipseCon EU and we expect that this will create attention for Celix.

- Most important issues to address before we can graduate: 
Make a first release, growing the community and attracting more committers.  

- Any issues the Incubator PMC or ASF board need to be aware of: 
None at this time 

- How has the community developed since the last report: 
There has been a small decrease on activity on the mailing list, hopefully this is a temporary decrease due to the holidays. We did receive patches from a contributor. 

- How has the project developed since the last report: 
We are still working towards a first release. The code base has been prepared for release and the website got some attention
based on the shepherd's view from last report. 

[1]: http://celix.apache.org/community/boardreports/boardreports.html#2012-04
[2]: http://celix.apache.org/community/boardreports/boardreports.html#2012-07

Signed off by mentor: marrs

## [2012-07](http://wiki.apache.org/incubator/July2012)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

Over the last months we have started working on "Native-OSGi" which is an effort to make a specification for a C and C++ bases OSGi implementation. As detailed in the graduation plan [1] in the previous report we hope to attract more community members with this move.
Details for Native-OSGi can be found at [2].

Also the donation of the Device Access code has been finished and committed to the SVN repository. This has been a good experience from both a technical and a process point of view.

Furthermore there has been a slight increase on the mailing list, hopefully this is a trend that will continue in the coming months.

* Most important issues to address before we can graduate

  Make a first release and grow a larger community. It is also needed to attract some more committers, there are currently 2. We are in the process of cleaning up the code and project structure so a first release can be made.

* Any issues the Incubator PMC or ASF board not te be aware of

  None at this time

* How has the community developed since the last report

  There has been an increase on the mailing list, furthermore with the start of the Native-OSGi project we hope this will increase in the coming months.

* How has the project developed since the last report 

  From a technical point of view, we are working towards a first release. The build files have been updated to support a more modular project structure.
Since the implementation is moving forward (al be it slowly), the community growth is the biggest concern for Celix.

[1]: http://celix.apache.org/community/boardreports/boardreports.html#2012-04
[2]: https://github.com/abroekhuis/NativeOSGi

Signed off by mentor:

Shepherd: Matt Franklin

## [2012-04](http://wiki.apache.org/incubator/April2012)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

The last month we received or first large code donation, the code still has to be added to the project. This code is an implementation of the OSGi Device Access specification for Celix and has been made by Thales Netherlands. Together with this donation a new committer (Pepijn Noltes) is accepted. Pepijn has developed and will maintain the Device Access code.

We have also been working on a graduation plan which is included below.

Most important issues are:

    Improve robustness (APR, error handling etc), resulting in a first release
    Update/Implement remote services for interoperability with Java OSGi (Apache Felix)
    Generate awareness and grow a community!

Graduation Plan

Celix is in incubation since November 2010. During the first one and a half year talks where given at several conferences (EclipseCon, ApacheCon, OSGi User Group meetings, etc).
Even though there seems to be an interest in the project, two important questions keep coming up:

- What is the state of the project?
- Why no support for C++?

Trying to answer/solve these two questions might make it able to attract more community members. So this plan will focus mostly on these two items.

= State of the project

== Releases

Celix entered incubation in its early stage. There was only a proof of concept, but no complete implementation. 
This is an important reason for people to hold back and not yet use/improve Celix, on the other hand,  being hesitant also keeps Celix from growing towards a more stable/robust solution.
To be able to use Celix the implementation has to reach, at least, a more stable state. Over the past year lots of effort has been put into this.
Within the next half year a release has to be made of the core component of Celix. Hopefully this will attract more users/testers (and potentially committers).
Since a formal release takes quite some effort, it might also make sense to provide snapshots (with documentation) to be able to reach more people.

== Committers

During the last months there has been an interest from Thales Netherlands to use Celix in its middleware. In a research project they are working on an implementation of the Device Access specification. This implementation is donated to Celix, and the main developer has expressed the intention to maintain the code base. Via this path a new committer has been added to Celix [1][2].
But to be able to have a diverse community more committers are needed.
Having a release makes it easier for people to use and improve Celix. This is one step towards more committers.

[1]: http://markmail.org/thread/hfwuspl3swoisenq
[2]: http://markmail.org/message/q4n7562jvngd33s5

== Technical state

One of the important aspects of Celix is interoperability with Java OSGi through remote services. Currently Celix has basic support for Celix to Celix remote services, following the Remote Service Admin specification of OSGi. This implementation has to be improved and extended to comply better to the specification. Also a Java OSGi implementation has to be made which can interact with the Celix implementation. Some existing opensource solutions are available, but are either to large for our intended target platforms or rely on to many other libraries (for example XML handling etc). To be able to have an implementation which fits the environment ((de)serialization and protocol) it makes sense to implement a simple solution ourselves.
Having functional remote services makes it easier to use Celix in a mixed Java/C environment. This solution can also be positioned as an alternative to JNI with the benefit that the Java and C components are separate processes. If either one crashes the other part is kept running, resulting in a more robust solution.
 
= C++ Support

== Technical Scope

Currently Celix is limited to C only. This was a deliberate choice since Celix tries to target  embedded/constrained platforms. But during talks people also seem to be interested in C++ support. Extending the technical scope of the project might attract more users and committers.
Over the next half year we will work out a plan how C++ support can be added without impacting the current supported platforms. A start with the discussions has been made on the mailinglist, see [2] for more information.

[3]: http://markmail.org/thread/a3qltqhsocmrnerd

== Cooperate with existing C++ OSGi like implementations

In [3] a list of similar projects is mentioned. Reaching out to these projects and trying to find a common ground on requirements/API etc could benefit Celix (and those projects as well). 
To see if there is a common ground we need to contact those projects and plan a meeting.

Signed off by mentor:

## [2012-01](http://wiki.apache.org/incubator/January2012)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

Over the last few months lots of work has been put into integrating APR and updating the Celix code base to the proposed code style. This code style has partially been documented on [1]. Also some effort has been put into updating the source for Visual Studio, even though not yet finished some interesting and helpful patches where submitted and applied.

In Oktober an event was held to create more awareness for services, OSGi and Celix in the Dutch embedded community. The attendance was great, and a follow-up will be planned. Also, in November a talk was given at the ApacheCon.

As listed below, one of the most important issues is the slow growth of the Celix community. With the current discussion about poddlings and how long a poddling is in the incubator, we are discussing a plan how we can move to a more diverse community and be able to graduate. This plan will be included in the next board report.

Most important issues are:

    Improve robustness (APR, error handling etc), resulting in a first release
    Generate awareness and grow a community!


Signed off by mentor: marrs

[1]: http://celix.apache.org/documentation/mapping.html

## [2011-10](http://wiki.apache.org/incubator/October2011)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

In the code not much has changed during the past few months, mostly due to vacations. Some (reported) bugs have been fixed, and some interesting examples have been added. These example where donated by a user, and follow the OSGi in Action book. This makes them a great addition to Celix.
Furthermore, some work has been done to make testing from CMake easier, and we are also looking into a method for mocking services to be able to test only one service without all its dependencies.

On the community site, Luminis and Thales are organizing an event (in Dutch) to introduce embedded/distributed companies to OSGi. During this event OSGi will be explained, Celix and PojoSR will be introduced. Also a small introduction in Apache and the "Apache Way" will be given, with the goal to invite people to use/join Celix.
Also, in november a talk and demo will be given at the ApacheCon.

Most important issues are:

    Improve robustness (APR, error handling etc)
    Generate awareness and grow a community!

Signed off by mentor:

## [2011-07](http://wiki.apache.org/incubator/July2011)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

Over the past few months work has been done on integration and usage of the Apache Portable Runtim (APR) in Celix.
The work has mostly focusses on stability and robustness of the codebase, but some new features were added:
  
    Log Service and Writer: for logging and reading the log
    Service Factories: needed for the log service

Also, in March, a talk was given to the OSGi User Group France. There is a lot interest in the project, but people seem to be waiting for a more stable version.
For community building it might be interesting to work towards a release later this year to make it easier to download and use Celix.
A talk on Celix has also been accepted for the ApacheCon in November, which is a good opportunity to show Celix to the world.
Also parts of Celix have been ported to Windows. Mostly the utils used by the framework, and not yet the framework itself. This is a lengthy job because Celix is using C99, and Windows (Visual Studio) only support C89/C90.

Most important issues are:

    Improve robustness (APR, error handling etc)
    Generate awareness and grow a community!

Signed off by mentor:

## [2011-04](http://wiki.apache.org/incubator/April2011)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

During the EclipseCon a talk was given over Celix, also spoke with several OSGi 
people who are interested in the progress, especially related to Universal OSGi 
(which details specification and requirements for OSGi in other languages).
During the last few weeks work has been done to get rid of memory leaks and null 
pointers.
Currently we are looking at the requirements/details for bundle deployment and 
updating, possibly in combination with Apache Ace.

Most important issues are:

    Define a status overview of what is and isn't working.
    Move all "sub" project to the new structure.
    Use APR for all file handling, threading etc.
    Generate awareness and grow a community

Signed off by mentor:

## [2011-02](http://wiki.apache.org/incubator/February2011)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

A new structure for the project has been used for the framework. In this structure public and private files are 
separated. This structure has not yet been applied to all "sub" project in Celix.
We are also looking at Apache APR for OS abstraction. Using APR would involve replacing all file handing, threading 
etc with APR functions.

Finally, work is being done for the talk on the EclipseCon.

Most important issues are:

Add more information to the wiki (ongoing process)
Move all "sub" project to the new structure.
Use APR for all file handling, threading etc.

Signed off by mentor:

## [2011-01](http://wiki.apache.org/incubator/January2011)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

Currently the source tree is being cleaned and correct header information is being added. We are also looking at the 
project structure and how it can be changed to get a better/simpler overview. Most important aspect is separating the 
actual framework from the additional bundles.

Additionally, last December a proposal for a Celix talk was sent to, and accepted by the EclipseCon/OSGi DevCon. This 
provides a great opportunity to increase awareness and build a community.

Most important issues are:

    Add more information to the wiki (ongoing process)
    Cleanup project, rearrange structure
    Generate awareness and grow a community!

Signed off by mentor: marrs 

## [2010-12](http://wiki.apache.org/incubator/December2010)

= Celix =

Celix is an implementation of the OSGi Specification in C.

Celix entered incubation on November 2, 2010.

As we are just accepted into the Incubator, startup is in progress. The donated code has been committed to 
SVN, and the project site is being created.

Most important issues are:

    Get everything (Jira, SVN, Website etc) up and running
    Cleanup code
    Generate awareness and grow a community.

Signed off by mentor: marrs
