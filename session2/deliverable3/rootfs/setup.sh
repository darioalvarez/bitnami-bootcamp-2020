#!/bin/bash

# Changing port
sed -i "s/listen 80/listen ${NGINX_PORT}/g" /etc/nginx/sites-available/default
sed -i "s/listen \[::\]:80/listen \[::\]:${NGINX_PORT}/g" /etc/nginx/sites-available/default

# Changing pid location
sed -i "s/pid \/run\/nginx.pid/pid \/tmp\/nginx.pid/g" /etc/nginx/nginx.conf

# ln -sf /dev/stdout /var/log/nginx/access.log
# ln -sf /dev/stderr /var/log/nginx/error.log
