#!/bin/bash

chown www-data.www-data /var/www -Rf
/usr/sbin/apache2 -D FOREGROUND

