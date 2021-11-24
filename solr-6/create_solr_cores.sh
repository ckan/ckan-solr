#!/bin/bash

SOLR_URLS="https://raw.githubusercontent.com/ckan/ckan/dev-v$CKAN_VERSION/ckan/config/solr/schema.xml
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/currency.xml
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/synonyms.txt
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/stopwords.txt
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/basic_configs/conf/protwords.txt
https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/$SOLR_VERSION/solr/server/solr/configsets/data_driven_schema_configs/conf/elevate.xml"


function create_core() {

    SOLR_CORE=$1
    CKAN_VERSION=$2

    if [ $CKAN_VERSION == 'master' ]
    then
        SCHEMA_URL="https://raw.githubusercontent.com/ckan/ckan/master/ckan/config/solr/schema.xml"
    else
        SCHEMA_URL="https://raw.githubusercontent.com/ckan/ckan/dev-v$CKAN_VERSION/ckan/config/solr/schema.xml"
    fi

    echo "Creating Solr core named '$SOLR_CORE' with CKAN version $CKAN_VERSION"

    SOLR_CORE_DIR=/opt/solr/server/solr/$SOLR_CORE/

    # Create Directories"
    mkdir -p $SOLR_CORE_DIR/conf
    mkdir -p $SOLR_CORE_DIR/data

    # Add schema from repo
    wget $SCHEMA_URL -P $SOLR_CORE_DIR/conf -q

    # Adding config files
    cp /tmp/solrconfig.xml $SOLR_CORE_DIR/conf/
    for url in $SOLR_URLS
    do
        wget $url -P $SOLR_CORE_DIR/conf -q
    done

    # Create Core.properties
    echo name=$SOLR_CORE > $SOLR_CORE_DIR/core.properties

    # Giving ownership to Solr
    chown -R $SOLR_USER:$SOLR_USER $SOLR_CORE_DIR
}

IFS=' ' read -a CKAN_VERSIONS <<< "$CKAN_VERSIONS"

if [ ${#CKAN_VERSIONS[@]} == 1 ]
then
    create_core "ckan" $CKAN_VERSIONS
else
    for CKAN_VERSION in ${CKAN_VERSIONS[@]}
    do
        if [ $CKAN_VERSION == 'master' ]
        then
            SOLR_CORE="master"
        else
            SOLR_CORE="ckan-$CKAN_VERSION"
        fi
        create_core $SOLR_CORE $CKAN_VERSION
    done
fi


