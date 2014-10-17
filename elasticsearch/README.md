# ElasticSearch

    $ docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -p 9001:9001 -v /var/lib/es/data:/usr/share/elasticsearch/data:rw -t cncflora/elasticsearch

## Packages
- Java 7
- ElasticSearch 1.3.2
- Supervisord

## Ports
- 9200 ElasticSearch Api
- 9300 ElasticSearch cluster (docker\_es)
- 9001 Supervisord web interface

## Volumes
- /usr/share/elasticsearch/data


