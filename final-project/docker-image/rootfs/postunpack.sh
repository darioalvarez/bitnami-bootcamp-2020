#!/bin/bash

# Step 2
mkdir -p /usr/lib/ckan/default


virtualenv --no-site-packages /usr/lib/ckan/default
. /usr/lib/ckan/default/bin/activate

pip install setuptools==36.1


pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.8.2#egg=ckan'

pip install -r /usr/lib/ckan/default/src/ckan/requirements.txt

deactivate
. /usr/lib/ckan/default/bin/activate

# Step 4
mkdir -p /etc/ckan/default
chown -R nonroot /etc/ckan
chown -R nonroot /var/lib/ckan
chown -R nonroot /usr/lib/ckan


# Step 6
ln -s /usr/lib/ckan/default/src/ckan/who.ini /etc/ckan/default/who.ini

useradd -p $(openssl passwd -1 ${CKAN_ADMIN_PASSWORD}) ${CKAN_ADMIN}
