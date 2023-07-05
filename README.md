# ckan-solr

Pre-configured Solr Docker images for CKAN.

**Note:** These images are built on top of [the upstream Solr images](https://github.com/apache/docker-solr#readme). These images receive bug fixes from time to time which we pull into ours, but you won't get them unless you re-pull the CKAN Solr image.


You can get a local Solr instance targeting a specific CKAN version by running the following command:

    docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr:2.10

The following versions are available as different image tags:

| CKAN Version | Solr version | Docker tag | Notes |
| --- | --- | --- | --- |
| 2.10 | Solr 8 | `ckan/ckan-solr:2.10` | |
| 2.10 | Solr 8 | `ckan/ckan-solr:2.10-spatial` | Contains fields needed for the [ckanext-spatial](https://docs.ckan.org/projects/ckanext-spatial/en/latest/spatial-search.html) geo search |
| 2.9 | Solr 8 | `ckan/ckan-solr:2.9-solr8` | Requires at least CKAN 2.9.5 |
| 2.9 | Solr 8 | `ckan/ckan-solr:2.9-solr8-spatial` | Contains fields needed for the [ckanext-spatial](https://docs.ckan.org/projects/ckanext-spatial/en/latest/spatial-search.html) geo search |
| master | Solr 8 | `ckan/ckan-solr:master` | The `master` image is built nightly |

The following tags are no longer supported:

| CKAN Version | Solr version | Docker tag | Legacy Docker tags | Notes |
| --- | --- | --- | --- | --- |
| 2.7 | Solr 6 | `ckan/ckan-solr:2.7` |  `ckan/ckan-solr-dev:2.7` | |
| 2.8 | Solr 6 | `ckan/ckan-solr:2.8` |  `ckan/ckan-solr-dev:2.8` | |
| 2.9 | Solr 6 | `ckan/ckan-solr:2.9` | `ckan/ckan-solr-dev:2.9` | |


All these images expose the CKAN Solr endpoint at **http://localhost:8983/solr/ckan**, so that's what you should set the value of `solr_url` in your ini file to.



### Building the images

For the Solr 8 based image (ie CKAN 2.10), go to the `solr-8` directory and use the Makefile included:

    # Default version in 2.10
    make build
    make build CKAN_VERSION=2.9

Note that pre-CKAN 2.10 images use tags with a `-solr8` suffix, ie `ckan/ckan-solr:2.9-solr8`


### Use your own configuration files

If you want to play around with the solr config files you can copy them from the container to your local host and then run the container with a bind mount.

1. Run a container (eg `multi`):

       docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr:multi

2. Copy the config file of the target core to your machine (eg `ckan-2.9`):

       docker cp ckan-solr:/opt/solr/server/solr/ckan-2.9/conf ./my_conf

3. Stop the container:

       docker stop ckan-solr

4. Run the container with a bind mount:

       docker run -p 8983:8983 --mount type=bind,source="$(pwd)"/my_conf,target=/opt/solr/server/solr/ckan-2.9/conf -d ckan/ckan-solr:multi

5. Edit your local files

6. Reload the core using the Solr admin page: http://localhost:8983/solr/#/~cores/
