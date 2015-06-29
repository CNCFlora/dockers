FROM debian:wheezy

RUN sed -i -e 's/http.debian.net/ftp.us.debian.org/g' /etc/apt/sources.list && \
    sed -i -e 's/httpredir/ftp.us/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential libffi-dev zlib1g-dev libssl-dev libyaml-dev libgdbm3 procps curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV ENV production
ENV RACK_ENV production
ENV version 2.2.2

RUN curl --insecure https://cache.ruby-lang.org/pub/ruby/2.2/ruby-$version.tar.gz -o /tmp/ruby-$version.tar.gz && \
    cd /tmp && \
    tar -xzf ruby-$version.tar.gz && \
    cd ruby-$version && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf ruby-$version && \
    rm -f ruby-$version.tar.gz

RUN mkdir /opt/app
WORKDIR /opt/app
