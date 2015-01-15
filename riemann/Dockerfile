FROM dockerfile/java:oracle-java8

RUN apt-get update && apt-get install supervisor ruby2.0 -y

RUN mkdir /var/log/supervisord 
ADD supervisord.conf /etc/supervisor/conf.d/proxy.conf

CMD ["supervisord"]

EXPOSE 4567
EXPOSE 5555
EXPOSE 5555/udp
EXPOSE 5556

RUN cd /opt && \
    wget http://aphyr.com/riemann/riemann-0.2.6.tar.bz2?jpg && \
    tar -xvf riemann-0.2.6.tar.bz2?jpg && \
    mv riemann-0.2.6 riemann

RUN sed -i -e "s|127.0.0.1|0.0.0.0|" /opt/riemann/etc/riemann.config

RUN apt-get install -y build-essential zlib1g-dev libssl-dev libyaml-dev ruby2.0-dev

RUN gem sources -r http://rubygems.org/ && gem sources -a https://rubygems.org/ && gem install riemann-tools riemann-dash --no-rdoc --no-ri

