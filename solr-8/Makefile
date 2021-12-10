.PHONY: all help build build-all push
SHELL := /bin/bash
CKAN_VERSION=2.10
TAG_NAME="ckan/ckan-solr:$(CKAN_VERSION)"
TAG_NAME_LEGACY="ckan/ckan-solr:$(CKAN_VERSION)-solr8"

all: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:	## Build a Solr 8 image for a specific CKAN version, `make build CKAN_VERSION=2.9` (default is 2.10)
ifeq ($(CKAN_VERSION),2.10)
	docker build -t $(TAG_NAME) .
else
	docker build -t $(TAG_NAME_LEGACY) .
endif

push: ## Push an image to the Docker registry, `make push CKAN_VERSION=2.9` (default is 2.10)
ifeq ($(CKAN_VERSION),2.10)
	docker push $(TAG_NAME)
else
	docker push $(TAG_NAME_LEGACY)
endif
