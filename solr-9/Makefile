.PHONY: all help build build-all push
SHELL := /bin/bash
CKAN_VERSION=2.11
CKAN_BRANCH=dev-v2.11
SOLR_VERSION=9.7
TAG_NAME="ckan/ckan-solr:$(CKAN_VERSION)-solr9"
ALT_TAG_NAME="ckan/ckan-solr:$(CKAN_VERSION)-solr$(SOLR_VERSION)"
TAG_NAME_SPATIAL="ckan/ckan-solr:$(CKAN_VERSION)-solr9-spatial"
ALT_TAG_NAME_SPATIAL="ckan/ckan-solr:$(CKAN_VERSION)-solr$(SOLR_VERSION)-spatial"

all: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build:	## Build a Solr 9 image for a specific CKAN version, `make build CKAN_VERSION=2.11 CKAN_BRANCH=dev-v2.11` 
	docker build -t $(TAG_NAME) -t $(ALT_TAG_NAME) --build-arg CKAN_BRANCH=$(CKAN_BRANCH) --build-arg SOLR_VERSION=$(SOLR_VERSION) .
	docker build -t $(TAG_NAME_SPATIAL) -t $(ALT_TAG_NAME_SPATIAL) -f Dockerfile.spatial --build-arg CKAN_BRANCH=$(CKAN_BRANCH)  --build-arg SOLR_VERSION=$(SOLR_VERSION) .

push: ## Push an image to the Docker registry, `make push CKAN_VERSION=2.9` (default is 2.10)
	docker push $(TAG_NAME)
	docker push $(ALT_TAG_NAME)
	docker push $(TAG_NAME_SPATIAL)
	docker push $(ALT_TAG_NAME_SPATIAL)
