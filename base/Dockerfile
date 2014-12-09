FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y && apt-get install supervisor rsyslog ruby2.0 psmisc wget curl -y
RUN gem sources -r http://rubygems.org/ && gem sources -a https://rubygems.org/ && gem install small-ops -v 0.0.35

RUN mkdir /var/log/supervisord
ADD supervisord.conf /etc/supervisor/conf.d/base.conf

EXPOSE 9001
CMD [ "supervisord" ]

