<!---
Copyright 2024 dah4k
SPDX-License-Identifier: EPL-2.0
-->

# [Arkime](https://github.com/arkime/arkime/) Docker image/container

This repository builds Arkime container on PhotonOS for CI/CD.


## Getting Started

### Prerequisites

The build host (or cloud instance) requires:

* `docker`
* `make`


### Build the container

```
% make arkime
```

### Run the container

> :warning: OpenSeach/ElasticSearch is not configured

```
% docker run local/arkime
...
WARNING - Using authMode=digest since not set, add to config file to silence this warning.
ERROR - fetching aliases ConnectionError: getaddrinfo ENOTFOUND arkime_elasticsearch
ERROR - OpenSearch/Elasticsearch ConnectionError: getaddrinfo ENOTFOUND arkime_elasticsearch
...
Getting OpenSearch/Elasticsearch info failed - the above error message might explain why
Common issues:
  * Is OpenSearch/Elasticsearch running and NOT RED?
  * Have you run 'db/db.pl <host:port> init'?
  * Is the 'elasticsearch' setting (http://ARKIME_ELASTICSEARCH) correct in config file (/opt/arkime/etc/config.ini) with a username and password if needed? (https://arkime.com/settings#elasticsearch)
  * Do you need the --insecure option? (See https://arkime.com/faq#insecure)
```


## Resources

* https://github.com/mammo0/docker-arkime/
* https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md
* https://github.com/docker/setup-qemu-action/blob/master/dev.Dockerfile
* https://github.com/vmware/photon/blob/master/docs/photon_installation/build-package-kernel-using-script.md

