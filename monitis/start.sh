#!/bin/bash

[[ "$HOST" = "" ]] && HOST=server

sed -i -e "s/server@cncflora/$HOST@cncflora/" /opt/monitis/etc/monitis.conf

/opt/monitis/monitis.sh start && /opt/monitis/monitis.sh log

