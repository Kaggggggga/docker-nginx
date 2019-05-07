#!/usr/bin/env bash
if [ ${NGINX_TEMPLATE} = "cache-proxy" ]; then
    echo "init-cache-proxy-default"
    mkdir -p $NGINX_CACHE_TEMP_PATH
    mkdir -p $NGINX_CACHE_PATH
fi
