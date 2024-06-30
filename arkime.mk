# Copyright 2024 dah4k
# SPDX-License-Identifier: EPL-2.0

arkime-dev:       ## Docker base image for Arkime development
arkime-runtime:   ## Docker base image for Arkime runtime
arkime-build:     ## Intermediate Docker image for compiling Arkime
arkime:           ## Docker image for running Arkime

arkime-dev arkime-runtime:
	$(DOCKER) build . \
		--build-arg REQUIREMENTS=$(REQUIREMENTS).$@ \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@

arkime-build: arkime-dev
	$(DOCKER) build . \
		--build-arg FROM_IMAGE_BASE=$(TAG_PREFIX)/$< \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@

arkime: arkime-build arkime-runtime
	$(DOCKER) build . \
		--build-arg FROM_IMAGE_ARTIFACT=$(TAG_PREFIX)/$(firstword $^) \
		--build-arg FROM_IMAGE_BASE=$(TAG_PREFIX)/$(lastword $^) \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@

.PHONY: arkime-dev arkime-runtime arkime-build arkime
