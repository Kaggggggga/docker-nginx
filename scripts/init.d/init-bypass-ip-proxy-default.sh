#!/usr/bin/env bash
if [ ${NGINX_TEMPLATE} = "bypass-ip-proxy" ]; then
    echo "init-bypass-ip-proxy-default"

    ## whitelist ip mappings
    IFS=',' read -ra list <<< "$NGINX_BYPASS_WHITELIST_IPS"
    nginx_confd_base="/etc/nginx/conf.d"

    allowed_value="$NGINX_BYPASS_UPSTEAM"
    denied_value="$NGINX_UPSTEAM"

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

    export NGINX_UPSTEAM='$switch'

    ## reuse template
    base="/nginx"
    file="${base}/templates/${NGINX_TEMPLATE}.conf"
    if [ ! -f $file ]; then
        cp "${base}/templates/simple-proxy.conf" $file
    fi

    ## for variable proxy_pass
    if [[ -z "${NGINX_DNS_RESOLVER_TYPE}" ]]; then
        export NGINX_DNS_RESOLVER_TYPE="docker-default"
    fi
fi
