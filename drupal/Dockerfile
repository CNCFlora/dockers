FROM ubuntu:14.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install apache2 curl wget libapache2-mod-php5 php5 php5-cli php5-curl php5-common php5-sqlite php5-mysql php5-pgsql php5-gd socat -y 

RUN a2enmod rewrite 

RUN sed -i -e 's/memory_limit.*/memory_limit=512M/g' /etc/php5/apache2/php.ini && \
    sed -i -e 's/upload_max_filesize.*/upload_max_filesize=128M/g' /etc/php5/apache2/php.ini && \
    sed -i -e 's/post_max_size.*/post_max_size=128M/g' /etc/php5/apache2/php.ini && \
    sed -i -e 's/display_errors.*/display_erros=On/g' /etc/php5/apache2/php.ini

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/apache2.pid
ENV PHP_ENV production
ADD default.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

ENV DRUPAL_VERSION 8.0.0-beta1

RUN wget http://ftp.drupal.org/files/projects/drupal-$DRUPAL_VERSION.tar.gz?jpg -O /var/www/drupal-$DRUPAL_VERSION.tar.gz

RUN cd /var/www && \
    tar -xvf drupal-$DRUPAL_VERSION.tar.gz && \
    rm html -Rf && \
    mv drupal-$DRUPAL_VERSION html  && \
    cd /var/www/html && \
    cp /var/www/html/sites /var/www/sites_default -a && \
    curl -sS https://getcomposer.org/installer | php && \
    php composer.phar update

ADD start.sh /root/start.sh
RUN chmod +x /root/start.sh

VOLUME ["/var/www/html/sites"]

CMD ["/root/start.sh"]

RUN chown www-data.www-data /var/www -Rf

