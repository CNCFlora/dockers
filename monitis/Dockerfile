FROM debian:wheezy

RUN sed -i -e 's/http.debian.net/ftp.us.debian.org/g' /etc/apt/sources.list && \
    sed -i -e 's/httpredir/ftp.us/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y 

RUN apt-get install -y openssl libxml2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD . /opt/monitis

WORKDIR /opt/monitis
CMD ["/opt/monitis/start.sh"]

