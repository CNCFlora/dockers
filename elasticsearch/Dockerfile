FROM ubuntu:14.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java7-installer

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.deb -O /root/elasticsearch-1.3.2.deb && \
    dpkg -i /root/elasticsearch-1.3.2.deb

RUN apt-get install supervisor wget -y

RUN mkdir /var/log/supervisord
ADD supervisord.conf /etc/supervisor/conf.d/elasticsearch.conf

VOLUME ["/usr/share/elasticsearch/data"]

EXPOSE 9200
EXPOSE 9300
EXPOSE 9001

CMD [ "supervisord" ]

