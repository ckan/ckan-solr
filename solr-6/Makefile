.PHONY: all help build build-all
SHELL := /bin/bash
CKAN_VERSION="2.9"
ALL_CKAN_VERSIONS="2.6 2.7 2.8 2.9"
TAG_NAME_LEGACY="ckan/ckan-solr-dev:$(CKAN_VERSION)"
TAG_NAME="ckan/ckan-solr:$(CKAN_VERSION)"

all: help
help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:	## Build a Solr image for a specific CKAN version eg `make build CKAN_VERSION=2.8` (default is 2.9)
	docker build --build-arg CKAN_VERSIONS="$(CKAN_VERSION)" --no-cache -t $(TAG_NAME_LEGACY) .
	docker build --build-arg CKAN_VERSIONS="$(CKAN_VERSION)" --no-cache -t $(TAG_NAME) .

build-multi: ## Build a single Solr image with all CKAN versions
	make build CKAN_VERSION=$(ALL_CKAN_VERSIONS) TAG_NAME="ckan/ckan-solr-dev:multi"
	make build CKAN_VERSION=$(ALL_CKAN_VERSIONS) TAG_NAME="ckan/ckan-solr:multi"
