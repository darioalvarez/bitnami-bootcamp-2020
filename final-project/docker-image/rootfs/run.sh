#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. /usr/lib/ckan/default/bin/activate
paster serve /etc/ckan/default/development.ini
