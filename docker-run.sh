#!/usr/bin/env bash
#
# run on local Docker to test Dockerfile
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
COMMIT=${COMMIT:-local}

docker build \
	--build-arg "COMMIT=${COMMIT}" \
	--build-arg LASTMOD=$(date -u +%Y-%m-%dT%H:%M:%SZ) \
	--tag gitlab-proxy \
	.

docker run \
	--env "PORT=${PORT}" \
	--publish ${PORT}:${PORT} \
	gitlab-proxy

