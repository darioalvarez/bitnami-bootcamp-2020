#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "$*" = "/run.sh"  ]]; then
    # info "** Starting ckan server **"
    /setup.sh
    # info "** Completed ckan server **"
fi

echo ""
exec "$@"
