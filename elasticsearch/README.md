# ElasticSearch

    $ docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -v /var/lib/es/data:/usr/share/elasticsearch/data:rw -t cncflora/elasticsearch

## Packages
- Java 8
- ElasticSearch 1.4.4

## Ports
- 9200 ElasticSearch Api
- 9300 ElasticSearch cluster (docker\_es)

## Volumes
- /usr/share/elasticsearch/data


