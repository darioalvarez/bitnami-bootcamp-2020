#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${CKAN_HOST}" = "" ]]; then
    echo 'Error: Environment variable CKAN_HOST is mandatory.'
    exit 1
fi

if [[ "${CKAN_PORT}" = "" ]]; then
    echo 'Error: Environment variable CKAN_PORT is mandatory.'
    exit 1
fi

if [[ "$*" = "/run.sh"  ]]; then
    /setup.sh
fi

exec "$@"
