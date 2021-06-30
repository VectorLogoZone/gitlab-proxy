FROM nginx:latest
RUN apt-get update && apt-get install -y jq && rm -rf /var/lib/apt/lists/*

COPY ./www /usr/share/nginx/html
COPY ./etc/nginx/templates /etc/nginx/templates

ARG COMMIT="(not set)"
ENV COMMIT=$COMMIT
ARG LASTMOD="(not set)"
ENV LASTMOD=$LASTMOD
RUN echo '{"success":true,"message":"OK"}' \
	| jq \
	  --arg COMMIT "${COMMIT}" \
	  --arg LASTMOD "${LASTMOD}" \
	  --arg BOOT "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
	  --arg TECH "$(nginx -v 2>&1 | cut -d ':' -f2 | xargs)" \
	  --sort-keys --compact-output \
	  '.commit=$COMMIT|.lastmod=$LASTMOD|.boot=$BOOT|.tech=$TECH' \
	  > /usr/share/nginx/html/status.json
