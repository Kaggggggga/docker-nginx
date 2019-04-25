#!/usr/bin/env bash
if [ ${NGINX_TEMPLATE} = "php-fpm-proxy" ]; then
    echo "init-php-fpm-proxy-default"
    mkdir -p $NGINX_PHP_ROOT
    touch "$NGINX_PHP_ROOT/index.php"
fi