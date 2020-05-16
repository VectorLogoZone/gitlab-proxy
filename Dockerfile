FROM nginx

COPY ./www /usr/share/nginx/html
COPY ./conf/default.conf /tmp/default.conf

CMD /bin/bash -c "envsubst '\$PORT' < /tmp/default.conf > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"