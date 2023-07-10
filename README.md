# ckan-solr

Pre-configured Solr Docker images for CKAN.

**Note:** These images are built on top of [the upstream Solr images](https://github.com/apache/docker-solr#readme). These images receive bug fixes from time to time which we pull into ours, but you won't get them unless you re-pull the CKAN Solr image.

The recommended Solr version for the currently supported CKAN version is **[Solr 9](https://solr.apache.org/downloads.html#about-versions-and-support)**.

You can get a local Solr instance targeting a specific CKAN version by running the following command:

    docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr:2.10-solr9

The following versions are available as different image tags:

| CKAN Version | Solr version | Docker tag | Notes |
| --- | --- | --- | --- |
| **2.10** | **Solr 9** | `ckan/ckan-solr:2.10-solr9` | This is the recommended version if you are unsure which one to use |
| 2.10 | Solr 9 | `ckan/ckan-solr:2.10-solr9-spatial` | Contains fields needed for the [ckanext-spatial](https://docs.ckan.org/projects/ckanext-spatial/en/latest/spatial-search.html) geo search |
| 2.10 | Solr 8 | `ckan/ckan-solr:2.10-solr8` (previously `ckan/ckan-solr:2.10`) | |
| 2.10 | Solr 8 | `ckan/ckan-solr:2.10-solr8-spatial` (previously `ckan/ckan-solr:2.10-spatial`) | Contains fields needed for the [ckanext-spatial](https://docs.ckan.org/projects/ckanext-spatial/en/latest/spatial-search.html) geo search |
| 2.9 | Solr 9 | `ckan/ckan-solr:2.9-solr9` | Requires at least CKAN 2.9.5 |
| 2.9 | Solr 9 | `ckan/ckan-solr:2.9-solr9-spatial` | Contains fields needed for the [ckanext-spatial](https://docs.ckan.org/projects/ckanext-spatial/en/latest/spatial-search.html) geo search |
| 2.9 | Solr 8 | `ckan/ckan-solr:2.9-solr8` | Requires at least CKAN 2.9.5 |
| 2.9 | Solr 8 | `ckan/ckan-solr:2.9-solr8-spatial` | Contains fields needed for the [ckanext-spatial](https://docs.ckan.org/projects/ckanext-spatial/en/latest/spatial-search.html) geo search |
| master | Solr 9 | `ckan/ckan-solr:master` | The `master` image is built nightly |

The following tags are no longer supported:

| CKAN Version | Solr version | Docker tag | Legacy Docker tags | Notes |
| --- | --- | --- | --- | --- |
| 2.7 | Solr 6 | `ckan/ckan-solr:2.7` |  `ckan/ckan-solr-dev:2.7` | |
| 2.8 | Solr 6 | `ckan/ckan-solr:2.8` |  `ckan/ckan-solr-dev:2.8` | |
| 2.9 | Solr 6 | `ckan/ckan-solr:2.9` | `ckan/ckan-solr-dev:2.9` | |


All these images expose the CKAN Solr endpoint at **http://localhost:8983/solr/ckan**, so that's what you should set the value of `solr_url` in your ini file to.



### Building the images

Go to the relevant folder for the Solr version (eg `solr-9`) and use the Makefile included:

    # Default version in 2.10
    make build

    # Specify a different version
    make build CKAN_VERSION=2.9



### Use your own configuration files

If you want to play around with the solr config files you can copy them from the container to your local host and then run the container with a bind mount.

1. Run a container:

       docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr:2.10-solr9

2. Copy the config file of the target core to your machine (eg `ckan`):

       docker cp ckan-solr:/opt/solr/server/solr/ckan/conf ./my_conf

3. Stop the container:

       docker stop ckan-solr

4. Run the container with a bind mount:

       docker run -p 8983:8983 --mount type=bind,source="$(pwd)"/my_conf,target=/opt/solr/server/solr/ckan/conf -d ckan/ckan-solr:2.10-solr9

5. Edit your local files

6. Reload the core using the Solr admin page: http://localhost:8983/solr/#/~cores/
