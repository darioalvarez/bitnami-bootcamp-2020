#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "$*" = "/run.sh"  ]]; then
    # info "** Starting nginx server **"
    /setup.sh
    # info "** Completed nginx server **"
fi

echo ""
exec "$@"
