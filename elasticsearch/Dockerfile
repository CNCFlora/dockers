FROM cncflora/java8

RUN curl https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb  \
    --insecure -o /root/elasticsearch-1.4.4.deb 

RUN apt-get update && apt-get install adduser && \
    dpkg -i /root/elasticsearch-1.4.4.deb && rm /root/elasticsearch-1.4.4.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/usr/share/elasticsearch/data"]

EXPOSE 9200
EXPOSE 9300

CMD ["/usr/share/elasticsearch/bin/elasticsearch","--cluster.name","docker_es","--index.mapping.ignore_malformed","true"]

