#!/bin/bash

if [[ ! -e /var/www/html/sites/default ]]; then
    cp /var/www/sites_default/* /var/www/html/sites -a
    if [[ $MYSQL_PORT_3306_TCP_ADDR ]]; then
        socat TCP4-LISTEN:3306,fork,reuseaddr TCP4:$MYSQL_PORT_3306_TCP_ADDR:$MYSQL_PORT_3306_TCP_PORT &
        databases="\$databases=array('default'=>array('default' => array( 'driver' => 'mysql', 'database' => '$MYSQL_ENV_MYSQL_DATABASE', 'username' => '$MYSQL_ENV_MYSQL_USER', 'password' => '$MYSQL_ENV_MYSQL_PASSWORD', 'host' => '127.0.0.1','port'=>'3306', 'prefix' => '')));"
        sed -i -e "s/^\$databases = array();/$databases/" /var/www/html/sites/default/default.settings.php
    fi
fi

/usr/sbin/apache2 -DFOREGROUND

