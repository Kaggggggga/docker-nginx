#!/usr/bin/env bash
if [ ${NGINX_TEMPLATE} -eq "php-fpm-proxy" ]; then
    echo "init-php-fpm-proxy-default"
    touch "$NGINX_PHP_ROOT/index.php"
fi