FROM cncflora/java8

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.1.deb -O /root/elasticsearch-1.4.1.deb && \
    dpkg -i /root/elasticsearch-1.4.1.deb

ADD supervisord.conf /etc/supervisor/conf.d/elasticsearch.conf

VOLUME ["/usr/share/elasticsearch/data"]

EXPOSE 9200
EXPOSE 9300

CMD [ "supervisord" ]

