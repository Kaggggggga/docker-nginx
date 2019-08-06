#!/usr/bin/env bash
if [ ${NGINX_TEMPLATE} = "basic-auth-bypass-ip-proxy" ]; then
    echo "init-basic-auth-bypass-ip-proxy-default"

    ## whitelist ip mappings
    IFS=',' read -ra list <<< "$NGINX_BYPASS_WHITELIST_IPS"
    nginx_confd_base="/etc/nginx/conf.d"

    allowed_value="off"
    denied_value="on"

    ## rules
    allowed_block=""
    for ip in "${list[@]}";do
        ip=$(echo "$ip" | awk '{$1=$1};1')
        if [[ ! -z "$ip" ]]; then
            allowed_block="$allowed_block$ip $allowed_value;\n"
        fi
    done
    denied_block="default   $denied_value;\n"
    content=$(cat <<END
map \$remote_addr \$switch {\n
    $denied_block
    $allowed_block
}\n
END
)
    echo -ne $content >> "${nginx_confd_base}/map.conf"

    ## basic auth
    echo "$NGINX_BASIC_AUTH_USERNAME:{PLAIN}$NGINX_BASIC_AUTH_PASSWORD" > "$NGINX_BASIC_AUTH_PATH"
    [[ -z "$NGINX_BASIC_AUTH_REALM" ]] && export NGINX_BASIC_AUTH_REALM='$switch'

    ## reuse template
    base="/nginx"
    file="${base}/templates/${NGINX_TEMPLATE}.conf"
    if [ ! -f $file ]; then
        cp "${base}/templates/basic-auth-proxy.conf" $file
    fi
fi
