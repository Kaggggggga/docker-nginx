FROM nginx:1.14.2
WORKDIR /app
COPY app/. .

ENV NGINX_PORT=80
ENV NGINX_UPSTEAM="http://127.0.0.1:8080"
ENV NGINX_HEALTHZ="/healthz"
ENV NGINX_PROXY_HOST='$host'

ENV NGINX_STATIC_PATH="/static/"
ENV NGINX_STATIC_UPSTEAM="http://127.0.0.1:8080"
ENV NGINX_STATIC_INDEX="index.html"
ENV NGINX_STATIC_CACHE_LONG="30d"
ENV NGINX_STATIC_CACHE_SHORT="30s"

CMD bash start.sh