# Drupal 8

Drupal 8 on Apache 2.2, with optional mysql link and sites volume.

Run:
    
    $ docker run -d --name drupal -p 80:80 -v /var/lib/drupal:/var/www/html/sites -t cncflora/drupal

With mysql linked container:

    $ docker run -d --name mysql -e MYSQL_DATABASE=drupal -e MYSQL_USER=drupal -e MYSQL_PASSWORD=drupal -e MYSQL_ROOT_PASSWORD=root -t mysql 
    $ docker run -d --name drupal --link mysql:mysql -p 80:80 -v /var/lib/drupal:/var/www/html/sites -t cncflora/drupal

With small-ops fige:

    $ wget https://raw.githubusercontent.com/CNCFlora/dockers/master/drupal/fig.yml
    $ fige

