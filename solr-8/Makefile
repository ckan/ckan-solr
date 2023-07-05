.PHONY: all help build build-all push
SHELL := /bin/bash
CKAN_VERSION=2.10
TAG_NAME="ckan/ckan-solr:$(CKAN_VERSION)"
TAG_NAME_SPATIAL="ckan/ckan-solr:$(CKAN_VERSION)-solr8-spatial"
TAG_NAME_LEGACY="ckan/ckan-solr:$(CKAN_VERSION)-solr8"

all: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build:	## Build a Solr 8 image for a specific CKAN version, `make build CKAN_VERSION=2.9` (default is 2.10)
ifeq ($(CKAN_VERSION),$(filter $(CKAN_VERSION),2.10 master))
	docker build -t $(TAG_NAME) .
	docker build -t $(TAG_NAME_SPATIAL) -f Dockerfile.spatial .
else
	docker build -t $(TAG_NAME_LEGACY) .
	docker build -t $(TAG_NAME_SPATIAL) -f Dockerfile.spatial .
endif

push: ## Push an image to the Docker registry, `make push CKAN_VERSION=2.9` (default is 2.10)
ifeq ($(CKAN_VERSION),$(filter $(CKAN_VERSION),2.10 master))
	docker push $(TAG_NAME)
	docker push $(TAG_NAME_SPATIAL)
else
	docker push $(TAG_NAME_LEGACY)
	docker push $(TAG_NAME_SPATIAL)
endif
