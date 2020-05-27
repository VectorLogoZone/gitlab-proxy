FROM nginx

COPY ./www /usr/share/nginx/html
COPY ./conf/default.conf /tmp/default.conf

RUN apt-get update && apt-get install -y jq && rm -rf /var/lib/apt/lists/*
ARG COMMIT="(not set)"
ENV COMMIT=$COMMIT
RUN echo '{"success":true,"message":"OK"}' \
	| jq \
	  --arg COMMIT "${COMMIT}" \
	  --arg LASTMOD "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
	  --arg TECH "$(nginx -v 2>&1 | cut -d ':' -f2 | xargs)" \
	  --sort-keys --compact-output \
	  '.commit=$COMMIT|.lastmod=$LASTMOD|.tech=$TECH' \
	  > /usr/share/nginx/html/status.json

CMD /bin/bash -c "envsubst '\$PORT' < /tmp/default.conf > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
