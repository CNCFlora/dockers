FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y build-essential zlib1g-dev libssl-dev libyaml-dev wget

ENV version 2.1.1

RUN wget https://cache.ruby-lang.org/pub/ruby/2.1/ruby-$version.tar.gz -O /tmp/ruby-$version.tar.gz --no-check-certificate && \
    cd /tmp && \
    tar -xzf ruby-$version.tar.gz && \
    cd ruby-$version && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf ruby-$version && \
    rm -f ruby-$version.tar.gz

