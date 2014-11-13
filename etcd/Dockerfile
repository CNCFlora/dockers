FROM ubuntu:14.04
RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential curl git
RUN curl -s https://storage.googleapis.com/golang/go1.3.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
RUN cd /opt && git clone https://github.com/coreos/etcd.git 
RUN cd /opt/etcd && git checkout v0.4.6  && ./build
EXPOSE 4001 7001
ENTRYPOINT ["/opt/etcd/bin/etcd"]
