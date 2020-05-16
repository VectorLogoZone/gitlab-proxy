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
PORT=${PORT:-4000}
TMP_CONF=$(mktemp)

PORT=${PORT} envsubst '\$PORT' < conf/default.conf > "${TMP_CONF}"

echo "tmp file is ${TMP_CONF}"
cat ${TMP_CONF}

docker run \
    --publish ${PORT}:${PORT} \
    --volume "$(pwd)/www:/usr/share/nginx/html" \
    --volume "${TMP_CONF}:/etc/nginx/conf.d/default.conf" \
    nginx

