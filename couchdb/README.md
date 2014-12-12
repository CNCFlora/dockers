# CouchDB

    $ docker run -d --name couchdb --link elasticsearch:elasticsearch -p 5984:5984 -p 9001:9001 -v /var/lib/couchdb:/var/lib/couchdb:rw -t cncflora/couchdb


Will also run couchdb-extras bots:

  - history
  - elasticsearch river

## Packages
- CouchDB 1.5
- Supervisord
- Couchdb-extras

## Ports
- 5984 CouchDB
- 9001 Supervisord web interface

## Volumes
- /var/lib/couchdb

