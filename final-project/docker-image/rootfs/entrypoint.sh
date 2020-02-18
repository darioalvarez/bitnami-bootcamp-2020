#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "$*" = "/run.sh"  ]]; then
    /setup.sh
fi

exec "$@"
