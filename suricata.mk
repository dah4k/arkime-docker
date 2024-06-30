# Copyright 2024 dah4k
# SPDX-License-Identifier: EPL-2.0

suricata-dev:       ## Docker base image for Suricata development
suricata-runtime:   ## Docker base image for Suricata runtime
suricata-build:     ## Intermediate Docker image for compiling Suricata
suricata-verify:    ## Intermediate Docker image for regression testing Suricata Verify
suricata:           ## Docker image for running Suricata

suricata-dev suricata-runtime:
	$(DOCKER) build . \
		--build-arg REQUIREMENTS=$(REQUIREMENTS).$@ \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@

suricata-build: suricata-dev
	$(DOCKER) build . \
		--build-arg FROM_IMAGE_BASE=$(TAG_PREFIX)/$< \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@

suricata-verify: suricata-build suricata-dev
	$(DOCKER) build . \
		--build-arg FROM_IMAGE_ARTIFACT=$(TAG_PREFIX)/$(firstword $^) \
		--build-arg FROM_IMAGE_BASE=$(TAG_PREFIX)/$(lastword $^) \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@

ifdef SKIP_VERIFY
suricata: suricata-build suricata-runtime
	$(DOCKER) build . \
		--build-arg FROM_IMAGE_ARTIFACT=$(TAG_PREFIX)/$(firstword $^) \
		--build-arg FROM_IMAGE_BASE=$(TAG_PREFIX)/$(lastword $^) \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@
else
suricata: suricata-verify suricata-runtime
	$(DOCKER) run $(TAG_PREFIX)/$(firstword $^) $(SURICATA_VERIFY_OPTS)
	$(DOCKER) build . \
		--build-arg FROM_IMAGE_ARTIFACT=$(TAG_PREFIX)/$(firstword $^) \
		--build-arg FROM_IMAGE_BASE=$(TAG_PREFIX)/$(lastword $^) \
		--tag $(TAG_PREFIX)/$@ \
		--file $(DOCKERFILE).$@
endif

run-suricata-verify: suricata-verify ## Run Suricata Verify as a Docker App
	$(DOCKER) run $(TAG_PREFIX)/$(firstword $^) $(SURICATA_VERIFY_OPTS)

.PHONY: suricata-dev suricata-runtime suricata-build suricata-verify suricata
.PHONY: run-suricata-verify
