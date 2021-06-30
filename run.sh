#!/usr/bin/env bash
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

echo "INFO: running on port ${PORT}"

docker run \
	--env "PORT=${PORT}" \
    --publish ${PORT}:${PORT} \
    --volume "$(pwd)/www:/usr/share/nginx/html" \
    --volume "$(pwd)/etc/nginx/templates:/etc/nginx/templates" \
    nginx

