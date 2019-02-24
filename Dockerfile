FROM nginx:1.14.2
WORKDIR /nginx
COPY . .

ENV NGINX_PORT=80 \
    NGINX_UPSTEAM="http://127.0.0.1:8080" \
    NGINX_HEALTHZ="/healthz" \
    NGINX_PROXY_HOST='$host' \

    NGINX_STATIC_PATH="/static/" \
    NGINX_STATIC_UPSTEAM="http://127.0.0.1:8080" \
    NGINX_STATIC_INDEX="index.html" \
    NGINX_STATIC_CACHE_LONG="30d" \
    NGINX_STATIC_CACHE_SHORT="30s"

ENTRYPOINT ["/nginx/start.sh"]