#!/usr/bin/env bash
set -e

base="/nginx"
nginx_confd_base="/etc/nginx/conf.d"

replaces=`compgen -v | grep 'NGINX_'|awk '{print "\${"$0"}"}' | tr '\n' ','`
replaces="'$replaces'"

file="${base}/templates/${NGINX_TEMPLATE:-simple-proxy}.conf"
echo "using ${file} as template"
envsubst $replaces < "${file}" > "${nginx_confd_base}/default.conf"

if [[ ! -z "${NGINX_HEALTHZ}" ]]; then
    envsubst $replaces < "${base}/templates/healthz.conf" > "${nginx_confd_base}/healthz.conf"
fi

envsubst $replaces < "${base}/templates/global.conf" > "${nginx_confd_base}/global.conf"

nginx -g "daemon off;"