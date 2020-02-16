#!/bin/bash

# Changing port
# sed -i "s/listen 80/listen ${NGINX_PORT}/g" /etc/nginx/sites-available/default
# sed -i "s/listen \[::\]:80/listen \[::\]:${NGINX_PORT}/g" /etc/nginx/sites-available/default

# Changing pid location
# sed -i "s/pid \/run\/nginx.pid/pid \/tmp\/nginx.pid/g" /etc/nginx/nginx.conf

# ln -sf /dev/stdout /var/log/nginx/access.log
# ln -sf /dev/stderr /var/log/nginx/error.log

echo '------- Executing setup.sh -------'
sleep 10

PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"CREATE DATABASE my_datastore;"

PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"CREATE ROLE datastore_user_read WITH LOGIN CREATEDB PASSWORD 'password123';"

PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"CREATE ROLE datastore_user_write WITH LOGIN CREATEDB PASSWORD 'password123';"

PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"GRANT ALL PRIVILEGES ON DATABASE my_datastore TO datastore_user_read;"

PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"GRANT ALL PRIVILEGES ON DATABASE my_datastore TO datastore_user_write;"


PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"CREATE DATABASE my_database;"

PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"CREATE ROLE database_user WITH LOGIN CREATEDB PASSWORD 'password123';"

PGPASSWORD=password123 psql -h postgresql -U postgres -c \
"GRANT ALL PRIVILEGES ON DATABASE my_database TO database_user;"




# Step 7 !!!!!!! init database
cd /usr/lib/ckan/default/src/ckan
. /usr/lib/ckan/default/bin/activate
paster db init -c /etc/ckan/default/development.ini

paster --plugin=ckan user add dario email='daa.developer@gmail.com' password='12345678'  -c /etc/ckan/default/development.ini
paster --plugin=ckan sysadmin add dario -c /etc/ckan/default/development.ini

deactivate

echo '------- Complete setup.sh --------'
