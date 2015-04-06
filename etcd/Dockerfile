FROM debian:wheezy

RUN sed -i -e 's/http.debian.net/ftp.us.debian.org/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -qy curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /opt && \
    curl -L  https://github.com/coreos/etcd/releases/download/v2.0.5/etcd-v2.0.5-linux-amd64.tar.gz -o etcd-v2.0.5-linux-amd64.tar.gz && \
    tar xzvf etcd-v2.0.5-linux-amd64.tar.gz && \
    mv etcd-v2.0.5-linux-amd64 etcd && \
    rm etcd-v2.0.5-linux-amd64.tar.gz

EXPOSE 4001 7001

WORKDIR /opt/etcd

CMD ["/opt/etcd/etcd","--cors","*","--listen-client-urls","http://0.0.0.0:4001,http://0.0.0.0:2379","--listen-peer-urls","http://0.0.0.0:2380,http://0.0.0.0:7001"]
