# ckan-solr-dev

Pre-configured Solr Docker images for rapid CKAN development. You can get a local Solr instance targeting a specific CKAN version by running the following command:

    docker run --name ckan-solr-dev -p 8983:8983 -d ckan/ckan-solr-dev:2.9

The following versions are available as different image tags:

| CKAN Version | Docker tag |
| --- | --- |
| 2.6 | ckan/ckan-solr-dev:2.6 |
| 2.7 | ckan/ckan-solr-dev:2.7 |
| 2.8 | ckan/ckan-solr-dev:2.8 |
| 2.9 | ckan/ckan-solr-dev:2.9 |
| master (*) | ckan/ckan-solr-dev:master |

(*) The `master` image is not automatically updated and might be out of date

All these images expose the CKAN Solr endpoint at http://localhost:8983/solr/ckan, so that's what you should set the value of `solr_url` in your ini file to.


Additionally, there is a `multi` image which contains cores for all CKAN Versions in the same Solr server:

    docker run --name ckan-solr-dev -p 8983:8983 -d ckan/ckan-solr-dev:multi

This will expose the following Solr endpoints:

* http://localhost:8983/solr/ckan-2.6
* http://localhost:8983/solr/ckan-2.7
* http://localhost:8983/solr/ckan-2.8
* http://localhost:8983/solr/ckan-2.9
* http://localhost:8983/solr/master

### Use your own configuration files

If you want to play around with the solr config files you can copy them from the container to your local host and then run the container with a bind mount.

1. Run a container (eg `multi`):

       docker run --name ckan-solr-dev -p 8983:8983 -d ckan/ckan-solr-dev:multi

2. Copy the config file of the target core to your machine (eg `ckan-2.9`):

       docker cp ckan-solr-dev:/opt/solr/server/solr/ckan-2.9/conf ./my_conf

3. Stop the container:

       docker stop ckan-solr-dev

4. Run the container with a bind mount:

       docker run -p 8983:8983 --mount type=bind,source="$(pwd)"/my_conf,target=/opt/solr/server/solr/ckan-2.9/conf -d ckan/ckan-solr-dev:multi

5. Edit your local files

6. Reload the core using the Solr admin page: http://localhost:8983/solr/#/~cores/
