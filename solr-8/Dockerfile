FROM solr:8

EXPOSE 8983

# TODO: Update with master / new release branch when merged
ARG CKAN_BRANCH="solr-8.0"

# Copy all default config files to the CKAN configset
# We just need to change the schema
COPY default_conf /opt/solr-ckan
ADD --chown=solr https://raw.githubusercontent.com/ckan/ckan/$CKAN_BRANCH/ckan/config/solr/schema.xml \
    /opt/solr-ckan/conf/managed-schema

CMD ["solr-precreate", "ckan", "/opt/solr-ckan"]
