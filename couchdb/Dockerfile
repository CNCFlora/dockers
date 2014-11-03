FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install supervisor couchdb wget ruby -y

RUN gem sources -r http://rubygems.org/ && gem sources -a https://rubygems.org/ && gem install small-ops -v 0.0.34

RUN mkdir /var/log/supervisord
ADD supervisord.conf /etc/supervisor/conf.d/couchdb.conf

RUN sed -i -e 's/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/' /etc/couchdb/local.ini
RUN mkdir /var/run/couchdb

VOLUME ["/var/lib/couchdb"]

EXPOSE 5984
EXPOSE 9001

CMD [ "supervisord" ]

