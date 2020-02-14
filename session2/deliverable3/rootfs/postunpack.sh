#!/bin/bash

chmod g+w /etc/nginx/sites-available/default
chgrp www-data /etc/nginx/sites-available/default
sed -i "s/www-data\:\/var\/www\:\/usr\/sbin\/nologin/www-data\:\/var\/www\:\/bin\/bash/g" /etc/passwd
mkdir -m 700 /var/www
chown -R www-data: /var/www
chown -R www-data: /etc/nginx
chown -R www-data: /var/lib/nginx/
chown www-data: /etc/init.d/nginx

chown www-data: /var/log/nginx/access.log
chown www-data: /var/log/nginx/error.log
