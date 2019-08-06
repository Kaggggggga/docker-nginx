FROM nginx:1.14.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /nginx
COPY . .

ENV NGINX_PORT=80 \
    NGINX_TEMPLATE=default \
    NGINX_HEALTHZ="/healthz" \
    NGINX_UPSTEAM="http://127.0.0.1:8080" \
    NGINX_PROXY_HOST='$host' \
    NGINX_PROXY_TIMEOUT=60s \

    NGINX_STATIC_PATH="/static/" \
    NGINX_STATIC_UPSTEAM="http://127.0.0.1:8080" \
    NGINX_STATIC_ROOT="/srv/build/" \
    NGINX_STATIC_INDEX="index.html" \
    NGINX_STATIC_CACHE_LONG="30d" \
    NGINX_STATIC_CACHE_SHORT="30s" \
    NGINX_STATIC_CACHE_PROXY="30d" \
    NGINX_STATIC_CACHE_LOCAL="30s" \
    NGINX_STATIC_UPSTEAM_PATH="/" \

    NGINX_BACKEND_PATH="/api/" \
    NGINX_BACKEND_HOST='$host' \
    NGINX_BACKEND_UPSTEAM="http://127.0.0.1:3000" \
    NGINX_BACKEND_UPSTEAM_PATH="/" \

    NGINX_AUTH_SCHEME=Bearer \
    NGINX_AUTH_TOKEN="" \

    NGINX_PHP_ROOT=/srv/public \
    NGINX_PHP_SERVER=127.0.0.1:9000 \
    NGINX_PHP_STATUS_LOCATION=/php-fpm-status \
    NGINX_PHP_STATUS_PATH=/status \
    NGINX_PHP_PING_LOCATION=/php-fpm-ping \
    NGINX_PHP_PING_PATH=/ping \

    NGINX_CACHE_KEY='$uri' \
    NGINX_CACHE_METHOD='GET HEAD' \
    NGINX_CACHE_VALID='200 1d' \
    NGINX_CACHE_USE_STALE='error timeout invalid_header updating http_500 http_502 http_503 http_504' \
    NGINX_CACHE_LOCK_TIMEOUT=10s \
    NGINX_CACHE_PATH=/data/nginx/cache \
    NGINX_CACHE_TEMP_PATH=/data/nginx/cache-temp \
    NGINX_CACHE_INACTIVE_TIME=24h \
    NGINX_CACHE_MAX_SIZE=1g \
    NGINX_CACHE_KEY_ZONE_SIZE=10m \
    NGINX_CACHE_BACKGROUND_UPDATE=on \

    NGINX_REDIRECT_CODE=301 \
    NGINX_REDIRECT_PROTO=https \
    NGINX_REDIRECT_HOST='$host' \
    NGINX_REDIRECT_PORT='443' \
    NGINX_REDIRECT_PATH='$uri' \
    NGINX_REDIRECT_QUERYSTRING='$is_args$args' \

    NGINX_RELOAD_INTERVAL=""

ENTRYPOINT ["/nginx/start.sh"]
