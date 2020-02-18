#!/bin/bash

sleep 20

PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"CREATE DATABASE ${POSTGRESQL_CKAN_DATASTORE};"

PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"CREATE ROLE ${POSTGRESQL_DATASTORE_USER_READ} WITH LOGIN CREATEDB PASSWORD '${POSTGRESQL_DATASTORE_USER_READ_PASSWORD}';"

PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"CREATE ROLE ${POSTGRESQL_DATASTORE_USER_WRITE} WITH LOGIN CREATEDB PASSWORD '${POSTGRESQL_DATASTORE_USER_WRITE_PASSWORD}';"

PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"GRANT ALL PRIVILEGES ON DATABASE ${POSTGRESQL_CKAN_DATASTORE} TO ${POSTGRESQL_DATASTORE_USER_READ};"

PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"GRANT ALL PRIVILEGES ON DATABASE ${POSTGRESQL_CKAN_DATASTORE} TO ${POSTGRESQL_DATASTORE_USER_WRITE};"


PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"CREATE DATABASE ${POSTGRESQL_CKAN_DATABASE};"

PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"CREATE ROLE ${POSTGRESQL_DATABASE_USER} WITH LOGIN CREATEDB PASSWORD '${POSTGRESQL_DATABASE_USER_PASSWORD}';"

PGPASSWORD=password123 psql -h ${POSTGRESQL_HOST} -U postgres -c \
"GRANT ALL PRIVILEGES ON DATABASE ${POSTGRESQL_CKAN_DATABASE} TO ${POSTGRESQL_DATABASE_USER};"

cd /usr/lib/ckan/default/src/ckan
. /usr/lib/ckan/default/bin/activate

paster make-config ckan /etc/ckan/default/development.ini

sed -i "s!site_id=default!site_id=${CKAN_SITE_ID}!1" /etc/ckan/default/development.ini
sed -i "s!sqlalchemy.url = postgresql://ckan_default:pass@localhost/ckan_default!sqlalchemy.url = postgresql://${POSTGRESQL_DATABASE_USER}:${POSTGRESQL_DATABASE_USER_PASSWORD}@${POSTGRESQL_HOST}/${POSTGRESQL_CKAN_DATABASE}!1" /etc/ckan/default/development.ini
sed -i "s!ckan.site_url =!ckan.site_url = ${CKAN_HOST}:${CKAN_PORT}!1" /etc/ckan/default/development.ini
sed -i "s!#solr_url = http://127.0.0.1:8983/solr!solr_url = http://${SOLR_HOST}:${SOLR_PORT}/solr/${SOLR_CORE_NAME}!1" /etc/ckan/default/development.ini
sed -i "s!#ckan.redis.url = redis://localhost:6379/0!ckan.redis.url = redis://${REDIS_HOST}:${REDIS_PORT}/0!1" /etc/ckan/default/development.ini
sed -i "s!#ckan.storage_path = /var/lib/ckan!ckan.storage_path = ${CKAN_STORAGE_PATH}!1" /etc/ckan/default/development.ini
sed -i "s!ckan.plugins = stats text_view image_view recline_view!ckan.plugins = stats text_view image_view recline_view ${CKAN_PLUGINS}!1" /etc/ckan/default/development.ini
sed -i "s!#ckan.datastore.write_url = postgresql://ckan_default:pass@localhost/datastore_default!ckan.datastore.write_url = postgresql://${POSTGRESQL_DATASTORE_USER_WRITE}:${POSTGRESQL_DATASTORE_USER_WRITE_PASSWORD}@${POSTGRESQL_HOST}/${POSTGRESQL_CKAN_DATASTORE}!1" /etc/ckan/default/development.ini
sed -i "s!#ckan.datastore.read_url = postgresql://datastore_default:pass@localhost/datastore_default!ckan.datastore.read_url = postgresql://${POSTGRESQL_DATASTORE_USER_READ}:${POSTGRESQL_DATASTORE_USER_READ_PASSWORD}@${POSTGRESQL_HOST}/${POSTGRESQL_CKAN_DATASTORE}!1" /etc/ckan/default/development.ini

if [[ "${CKAN_INITIALIZE_DB}" = "yes"  ]]; then
   paster db init -c /etc/ckan/default/development.ini

   paster --plugin=ckan user add ${CKAN_ADMIN} email="${CKAN_ADMIN_EMAIL}" password="${CKAN_ADMIN_PASSWORD}" -c /etc/ckan/default/development.ini
    paster --plugin=ckan sysadmin add ${CKAN_ADMIN} -c /etc/ckan/default/development.ini
fi

deactivate
