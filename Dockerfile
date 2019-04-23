FROM nginx:1.14.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /nginx
COPY . .

ENV NGINX_PORT=80 \
    NGINX_UPSTEAM="http://127.0.0.1:8080" \
    NGINX_HEALTHZ="/healthz" \
    NGINX_PROXY_HOST='$host' \

    NGINX_STATIC_PATH="/static/" \
    NGINX_STATIC_UPSTEAM="http://127.0.0.1:8080" \
    NGINX_STATIC_ROOT="/srv/build/" \
    NGINX_STATIC_INDEX="index.html" \
    NGINX_STATIC_CACHE_LONG="30d" \
    NGINX_STATIC_CACHE_SHORT="30s" \

    NGINX_AUTH_SCHEME=Bearer \
    NGINX_AUTH_TOKEN="" \

    NGINX_PHP_ROOT=/srv/public \
    NGINX_PHP_SERVER=127.0.0.1:9000 \
    NGINX_PHP_STATUS_LOCATION=/php-fpm-status \
    NGINX_PHP_STATUS_PATH=/status \
    NGINX_PHP_PING_LOCATION=/php-fpm-ping \
    NGINX_PHP_PING_PATH=/ping \

    NGINX_RELOAD_INTERVAL=""

ENTRYPOINT ["/nginx/start.sh"]