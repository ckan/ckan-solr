# ckan-solr

Pre-configured Solr Docker images for CKAN. You can get a local Solr instance targeting a specific CKAN version by running the following command:

    docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr-dev:2.9

The following versions are available as different image tags:

| CKAN Version | Solr version | Docker tag |
| --- | --- | --- |
| 2.7 | Solr 6 | `ckan/ckan-solr:2.7`,  `ckan/ckan-solr-dev:2.7` |
| 2.8 | Solr 6 | `ckan/ckan-solr:2.8`,  `ckan/ckan-solr-dev:2.8` |
| 2.9 | Solr 6 | `ckan/ckan-solr:2.9`,  `ckan/ckan-solr-dev:2.9` |
| 2.10 [1] | Solr 8 | `ckan/ckan-solr:2.10` |
| master [2] | Solr 8 | `ckan/ckan-solr:master` |

_Note_: The `ckan/ckan-solr-dev:*` tags are deprecated, and only kept for backwards compatibility.

[1] The `ckan/ckan-solr:2.10` is also compatible with CKAN 2.9 instances that run at least version 2.9.5
[2] The `master` image is not automatically updated and might be out of date

All these images expose the CKAN Solr endpoint at http://localhost:8983/solr/ckan, so that's what you should set the value of `solr_url` in your ini file to.


Additionally, there is a `multi` image which contains cores for all CKAN Versions in the same Solr server:

    docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr:multi-solr6

This will expose the following Solr endpoints (based on Solr 6):

* http://localhost:8983/solr/ckan-2.6
* http://localhost:8983/solr/ckan-2.7
* http://localhost:8983/solr/ckan-2.8
* http://localhost:8983/solr/ckan-2.9

There is no multi image for Solr 8 yet.

### Building the images

For Solr 6 based images (ie CKAN 2.6 to 2.9), go to the `solr-6` directory and use the Makefile included:

    # Default version in 2.9
    make build  
    make build CKAN_VERSION=2.8 
    make build-multi

For the Solr 8 based image (ie CKAN 2.10), run:

    docker build -t ckan/ckan-solr:2.10 solr-8


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
