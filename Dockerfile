FROM nginx:stable-alpine

RUN addgroup -S -g 10001 arvada-viewers \
    && adduser -S -D -H -u 10001 -G arvada-viewers visitor \ 
    && mkdir -p /var/cache/nginx /tmp/nginx  \
    && chown -R 10001:10001 /var/cache/nginx /tmp/nginx

#COPY . /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

COPY --chown=10001:10001 index.html index.js data.js style.css /usr/share/nginx/html/
COPY --chown=10001:10001 img/ /usr/share/nginx/html/img/
COPY --chown=10001:10001 tiles/ /usr/share/nginx/html/tiles/
COPY --chown=10001:10001 vendor/ /usr/share/nginx/html/vendor/

USER 10001:10001 

EXPOSE 7070

CMD ["nginx", "-g", "daemon off;"]

