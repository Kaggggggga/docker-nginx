#!/usr/bin/env bash
if [ ${NGINX_TEMPLATE} = "redirect-proxy" ]; then
    echo "init-redirect-proxy-default"

    ## for better handle colon for port
    export NGINX_REDIRECT_PORT_COLON=""
    if [[ ! -z "$NGINX_REDIRECT_PORT" ]]; then
        export NGINX_REDIRECT_PORT_COLON=":$NGINX_REDIRECT_PORT"
    fi
fi
