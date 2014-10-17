# CouchDB

    $ docker run -d --name couchdb -p 5984:5984 -p 9001:9001 -v /var/lib/couchdb:/var/lib/couchdb:rw -t cncflora/couchdb

## Packages
- CouchDB 1.5
- Supervisord

## Ports
- 5984 CouchDB
- 9001 Supervisord web interface

## Volumes
- /var/lib/couchdb

