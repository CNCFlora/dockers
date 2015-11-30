FROM cncflora/java8

RUN curl https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb  \
    --insecure -o /root/elasticsearch-1.4.4.deb 

RUN apt-get update && apt-get install adduser && \
    dpkg -i /root/elasticsearch-1.4.4.deb && rm /root/elasticsearch-1.4.4.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /usr/share/elasticsearch/config && cp /etc/elasticsearch/* /usr/share/elasticsearch/config && mkdir /usr/share/elasticsearch/config/templates
RUN echo 'script.disable_dynamic: false' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'index.query.bool.max_clause_count: 600000' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'index.mapping.ignore_malformed: true' >> /usr/share/elasticsearch/config/elasticsearch.yml

WORKDIR /usr/share/elasticsearch

VOLUME ["/usr/share/elasticsearch/data"]

COPY template_1.json /usr/share/elasticsearch/config/templates/

EXPOSE 9200
EXPOSE 9300

CMD ["bin/elasticsearch","--cluster.name","docker_es","--index.mapping.ignore_malformed","true"]

