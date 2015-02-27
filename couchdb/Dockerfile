FROM ubuntu:14.04 

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install supervisor rsyslog ruby psmisc wget curl couchdb -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN gem sources -r http://rubygems.org/ && gem sources -a https://rubygems.org/

RUN sed -i -e 's/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/' /etc/couchdb/local.ini
RUN mkdir /var/run/couchdb && mkdir /var/log/supervisord
ADD supervisord.conf /etc/supervisor/conf.d/base.conf
ADD json.ini /etc/couchdb/local.d/json.ini

VOLUME ["/var/lib/couchdb"]
CMD [ "supervisord" ]

EXPOSE 9001
EXPOSE 5984

RUN gem install couchdb-extras -v 0.0.4

ADD supervisord.conf /etc/supervisor/conf.d/couchdb.conf
ADD bots.conf /etc/supervisor/conf.d/bots.conf

