FROM cncflora/base

RUN apt-get install couchdb -y

ADD supervisord.conf /etc/supervisor/conf.d/couchdb.conf

RUN sed -i -e 's/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/' /etc/couchdb/local.ini
RUN mkdir /var/run/couchdb

VOLUME ["/var/lib/couchdb"]

EXPOSE 5984

CMD [ "supervisord" ]

RUN gem install couchdb-extras -v 0.0.4

ADD bots.conf /etc/supervisor/conf.d/bots.conf

