#!/bin/bash

mkdir -p /usr/lib/ckan/default

virtualenv --no-site-packages /usr/lib/ckan/default
. /usr/lib/ckan/default/bin/activate

pip install setuptools==36.1

mkdir -p /usr/lib/ckan/default/src/
mv /app/ckan /usr/lib/ckan/default/src/
echo s | pip install -e 'git+file:///usr/lib/ckan/default/src/ckan.git@ckan-2.8.2#egg=ckan'

# pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.8.2#egg=ckan'

pip install -r /usr/lib/ckan/default/src/ckan/requirements.txt

deactivate
. /usr/lib/ckan/default/bin/activate

mkdir -p /etc/ckan/default

ln -s /usr/lib/ckan/default/src/ckan/who.ini /etc/ckan/default/who.ini

useradd -p $(openssl passwd -1 ${CKAN_ADMIN_PASSWORD}) ${CKAN_ADMIN}

mkdir -p /var/lib/ckan
chown -R nonroot /usr/lib/ckan/default/src/ckan/who.ini /etc/ckan /var/lib/ckan /usr/lib/ckan /etc/ckan/default
