FROM solr:6.6-slim
MAINTAINER CKAN Tech team

ENV SOLR_VERSION "6.6.6" 
ARG CKAN_VERSIONS="2.6 2.7 2.8 2.9"


COPY solrconfig.xml create_solr_cores.sh /tmp/

RUN /tmp/create_solr_cores.sh 
