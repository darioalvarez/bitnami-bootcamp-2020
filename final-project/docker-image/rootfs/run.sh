#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# /etc/init.d/nginx start
# nginx -g 'daemon off;'

# cd /usr/lib/ckan/default/src/ckan
. /usr/lib/ckan/default/bin/activate
paster serve /etc/ckan/default/development.ini
