#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# /etc/init.d/nginx start
nginx -g 'daemon off;'
