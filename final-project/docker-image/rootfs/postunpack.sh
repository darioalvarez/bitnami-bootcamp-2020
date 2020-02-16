#!/bin/bash

# Step 2
mkdir -p /usr/lib/ckan/default
# sudo chown `whoami` /usr/lib/ckan/default
virtualenv --no-site-packages /usr/lib/ckan/default
. /usr/lib/ckan/default/bin/activate

pip install setuptools==36.1

pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.8.2#egg=ckan'

pip install -r /usr/lib/ckan/default/src/ckan/requirements.txt

deactivate
. /usr/lib/ckan/default/bin/activate

install_packages libmagic-dev postgresql-client vim

# Step 4
mkdir -p /etc/ckan/default
# chown -R `whoami` /etc/ckan/
# chown -R `whoami` ~/ckan/etc

paster make-config ckan /etc/ckan/default/development.ini


# Edit development.ini file
# site_id=default1
sed -i 's!sqlalchemy.url = postgresql://ckan_default:pass@localhost/ckan_default!sqlalchemy.url = postgresql://database_user:password123@postgresql/my_database!1' /etc/ckan/default/development.ini
sed -i 's!ckan.site_url =!ckan.site_url = http://ckan.local.net:5000!1' /etc/ckan/default/development.ini
sed -i 's!#solr_url = http://127.0.0.1:8983/solr!solr_url = http://solr:8983/solr/ckan-core!1' /etc/ckan/default/development.ini
sed -i 's!#ckan.redis.url = redis://localhost:6379/0!ckan.redis.url = redis://redis:6379/0!1' /etc/ckan/default/development.ini
sed -i 's!#ckan.storage_path = /var/lib/ckan!ckan.storage_path = /var/lib/ckan!1' /etc/ckan/default/development.ini
sed -i 's!ckan.plugins = stats text_view image_view recline_view!ckan.plugins = stats text_view image_view recline_view datastore!1' /etc/ckan/default/development.ini
sed -i 's!#ckan.datastore.write_url = postgresql://ckan_default:pass@localhost/datastore_default!ckan.datastore.write_url = postgresql://datastore_user_write:password123@postgresql/my_datastore!1' /etc/ckan/default/development.ini
sed -i 's!#ckan.datastore.read_url = postgresql://datastore_default:pass@localhost/datastore_default!ckan.datastore.read_url = postgresql://datastore_user_read:password123@postgresql/my_datastore!1' /etc/ckan/default/development.ini

# Step 6
ln -s /usr/lib/ckan/default/src/ckan/who.ini /etc/ckan/default/who.ini





useradd -p $(openssl passwd -1 dario) dario



