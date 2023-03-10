DOCKER      ?= docker
PRODUCTS    ?= arkime suricata dc
TAG_PREFIX  ?= local

DOCKERFILE  := docker/Dockerfile
REQUIREMENTS:= docker/Requirements
_ANSI_NORM  := \033[0m
_ANSI_CYAN  := \033[36m

help usage:
	@grep -hE '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?##"}; {printf "$(_ANSI_CYAN)%-20s$(_ANSI_NORM) %s\n", $$1, $$2}'

all: $(PRODUCTS) ## Build all container images

-include $(addsuffix .mk,$(PRODUCTS))

clean: ## Prune container images
	$(DOCKER) image prune --force
	$(DOCKER) system prune --force

distclean: ## Delete build artifacts
	-rm -f artifacts/*

.PHONY: help usage clean distclean
