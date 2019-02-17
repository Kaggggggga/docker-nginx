FROM nginx:1.14.2
WORKDIR /app
COPY app/. .

ENV NGINX_PORT 80
ENV NGINX_UPSTEAM "http://127.0.0.1:8080"
ENV NGINX_HEALTHZ "/healthz"

CMD bash start.sh