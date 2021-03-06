#!/usr/bin/env bash
if [ ${NGINX_TEMPLATE} = "basic-auth-proxy" ]; then
    echo "init-basic-auth-proxy-default"
    echo "$NGINX_BASIC_AUTH_USERNAME:{PLAIN}$NGINX_BASIC_AUTH_PASSWORD" > "$NGINX_BASIC_AUTH_PATH"
    if [[ -z "$NGINX_BASIC_AUTH_REALM" ]]; then
        export NGINX_BASIC_AUTH_REALM='Authentication Required'
    fi
fi
