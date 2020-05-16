#!/bin/bash
#
# run locally for dev
#

set -o errexit
set -o pipefail
set -o nounset

#
# load an .env file if it exists
#
ENV_FILE="${1:-./.env}"
if [ -f "${ENV_FILE}" ]; then
    echo "INFO: loading '${ENV_FILE}'"
    export $(cat "${ENV_FILE}")
fi

docker run \
    --publish ${PORT:-4000}:80 \
    --volume "$(pwd)/www:/usr/share/nginx/html" \
    --volume "$(pwd)/conf/default.conf:/etc/nginx/conf.d/default.conf" \
    nginx

