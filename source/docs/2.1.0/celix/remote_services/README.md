---
type: celix-doc
title: Remote Service Admin Service
version: 2.1.0
---

<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at
   
    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

## Introduction

The Remote Service Admin Service subproject contains an adapted implementation of the OSGi Enterprise Remote Service Admin Service Specification. The subproject consists of three parts, each described in more detail in the following sections.

### Topology Manager

The topology manager decides which services should be imported and exported according to a defined policy. Currently, only one policy is implemented in Celix, the *promiscuous* policy, which simply imports and exports all services.

| **Bundle** | `topology_manager.zip` |
|--|--|
| **Configuration** | *None* |

### Remote Service Admin

The Remote Service Admin (RSA) provides the mechanisms to import and export services when instructed to do so by the Topology Manager. 

#### Endpoints and proxies

To delegate a *received* method call to the actual service implementation, the RSA uses an "endpoint" bundle, which has all the knowledge about the marshalling and unmarshalling of data for the service. This endpoint bundle is specific to the used RSA implementation, and as such cannot be reused between various RSA implementations.

Invoking a *remote* method is done by using "proxy" bundles. Similar as to endpoints, proxy bundles encapsulate all knowledge to marshall and unmarshall data for a remote method call and as such can not be shared between RSA implementations.

Both proxy and endpoint bundles are loaded on demand when a service is imported or exported by the RSA. As such, these bundles **must** not be added to the list of "auto started" bundles, but placed in a separate location. By default, `endpoints` is used as location for locating proxy and/or endpoint bundles.

Note that since endpoints and proxies need to be created manually, one has full control about the handling of specifics of marshalling and unmarshalling data and dealing with exceptions. 

#### HTTP/JSON

Provides a RSA implementation that uses JSON to marshal requests and HTTP as transport mechanism for its remote method invocation. It is compatible with the *Remote Service Admin HTTP* implementation provided by [Amdatu Remote](https://amdatu.atlassian.net/wiki/display/AMDATUDEV/Amdatu+Remote).

| **Bundle** | `remote_service_admin_http.zip` |
|--|--|
| **Configuration** | `RSA_PORT`: defines the port on which the HTTP server should listen for incoming requests. Defaults to port `8888`; |
| | `ENDPOINTS`: defines the location in which service endpoints and/or proxies can be found. Defaults to `endpoints` in the current working directory |

#### Shared memory (SHM)

Provides a RSA implementation that uses shared memory for its remote method invocation. Note that this only works when all remote services are located on the same machine.

| **Bundle** | `remote_service_admin_shm.zip` |
|--|--|
| **Configuration** | `ENDPOINTS`: defines the location in which service endpoints and/or proxies can be found. Defaults to `endpoints` in the current working directory |

### Discovery

Actively discovers the presence of remote exported services and provides information about local exported services, as given by the Topology Manager, to others.

#### Shared memory (SHM) based discovery

Provides service discovery for the RSA SHM implementation.

| **Bundle** | `discovery_shm.zip` |
|--|--|
| **Configuration** | *None* |

#### Configured discovery

Provides a service discovery with preconfigured discovery endpoints, allowing a static mesh of nodes for remote service invocation to be created. The configured discovery bundle in Celix is compatible with the configured discovery implementation provided by [Amdatu Remote](https://amdatu.atlassian.net/wiki/display/AMDATUDEV/Amdatu+Remote).

| **Bundle** | `discovery_configured.zip` |
|--|--|
| **Configuration** | `DISCOVERY_CFG_POLL_ENDPOINTS`: defines a comma-separated list of discovery endpoints that should be used to query for remote services. Defaults to `http://localhost:9999/org.apache.celix.discovery.configured`; |
| | `DISCOVERY_CFG_POLL_INTERVAL`: defines the interval (in seconds) in which the discovery endpoints should be polled. Defaults to `10` seconds. |
| | `DISCOVERY_CFG_SERVER_PORT`: defines the port on which the HTTP server should listen for incoming requests from other configured discovery endpoints. Defaults to port `9999`; |
| | `DISCOVERY_CFG_SERVER_PATH`: defines the path on which the HTTP server should accept requests from other configured discovery endpoints. Defaults to `/org.apache.celix.discovery.configured`. |

Note that for configured discovery, the "Endpoint Description Extender" XML format defined in the OSGi Remote Service Admin specification (section 122.8 of OSGi Enterprise 5.0.0) is used.

See [etcd discovery](discovery_etcd/README.html)

#### etcd discovery 

| **Bundle** | `discovery_etcd.zip` |

Provides a service discovery using etcd distributd key/value store. 

See [etcd discovery](discovery_etcd/README.html)

## Usage

To develop for the Remote Service Admin implementation of Celix, one needs the following:

1. A service **interface**, describes the actual service and methods[^1] that can be called. The service interface is needed at development time to allow a consistent definition;
2. A service **implementation**, when exporting it as remote service. A service endpoint is needed to delegate remote requests to your service implementation;
3. A service **endpoint**, which will be installed by Celix when exporting a local service. The endpoint is responsible for calling the actual Celix service. Endpoint bundles are not needed when *only* importing services in Celix;
4. A service **proxy**, which will be installed by Celix when importing a remote service. The proxy is responsible for marshalling and unmarshalling method invocations. Proxy bundles are not needed when *only* exposing services from Celix;
5. A service **client** or user, which invokes methods on the local or remote service. The client is oblivious to the fact whether the service is running locally or remote.

The Celix source repository provides a simple calculator example that shows all of the described parts:

1. [The calculator service interface](http://svn.apache.org/repos/asf/celix/trunk/remote_services/calculator_service/public/include/calculator_service.h), providing three methods: one for adding two numbers, one for subtracting two numbers, and lastly, a method that calculates the square root of a number;
2. [A calculator service implementation](http://svn.apache.org/repos/asf/celix/trunk/remote_services/calculator_service/private/src/calculator_impl.c) that simply implements the three previously described functions. To mark this service as "remote service", you need to add the `service.exported.interfaces` service property to its service registration. This way, the RSA implementation can expose it as remote service to others;
3. [A service endpoint](http://svn.apache.org/repos/asf/celix/trunk/remote_services/calculator_endpoint/private/src/calculator_endpoint_impl.c), which is called by the RSA implementation to delegate a method invocation to an actual method in the service implementation. The service endpoint should be registered as `remote_endpoint` service, along with the `remote.interface` service property denoting which service interface this endpoint is capable of handling;
4. [A service proxy (factory)](http://svn.apache.org/repos/asf/celix/trunk/remote_services/calculator_proxy/private/src/calculator_proxy_impl.c), called by the service client when it wants to invoke a method on a remoted service. The service proxy should be registered as `remote_proxy_factory` service along with the `proxy.interface` service property denoting which service interface the service proxy is capable of handling;
5. [A service client](http://svn.apache.org/repos/asf/celix/trunk/remote_services/calculator_shell/private/src/add_command.c), that exposes the three calculator methods to as Celix shell commands. The implementation simply retrieves the calculator service as it would do with any other Celix service.

If you have access to the Celix source repository, you can run the calculator example using various discovery implementations by invoking the `deploy` target. You can find the example deployments in the `CELIX_BUILD/deploy` directory. For example, to run the calculator example using the configured discovery mechanism, you should open two terminals. In the first terminal, type:

    remote-service-cfg$ export RSA_PORT=18888
    remote-service-cfg$ sh run.sh
    ...
    RSA: Export services (org.apache.celix.calc.api.Calculator)
    ...
    -> _

In the second terminal, type:

    remote-service-cfg-client$ export RSA_PORT=28888
    remote-service-cfg-client$ sh run.sh
    ...
    RSA: Import service org.apache.celix.calc.api.Calculator
    ...
    -> _

Now, if all went well, the client (second terminal) has three new shell commands, `add`, `sub` and `sqrt`, which you can use to invoke the calculator service:

    -> add 3 5
    CALCULATOR_SHELL: Add: 3.000000 + 5.000000 = 8.000000
    -> _

On the server side (first terminal), you can follow each invocation as well:

    CALCULATOR_ENDPOINT: Handle request "add(DD)D" with data "{"m": "add(DD)D", "a": [3.0, 5.0]}"
    CALCULATOR: Add: 3.000000 + 5.000000 = 8.000000

Note that the `RSA_PORT` property needs to be unique for at least the client in order to communicate correctly when running the examples on the same machine. 

## Building

To build the Remote Service Admin Service the CMake build option "`BUILD_REMOTE_SERVICE_ADMIN`" has to be enabled.

## Dependencies

The Remote Service Admin Service depends on the following subprojects:

- Framework
- Utils

Also the following libraries are required for building and/or using the Remote Service Admin Service subproject:

- Jansson (build and runtime)
- cURL (build and runtime)


## Notes

[^1]: Although C does not use the term "method", we use this term to align with the terminology used in the RSA specification. 
