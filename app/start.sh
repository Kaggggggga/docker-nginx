#!/usr/bin/env bash
set -e

base="/app"

replaces=`compgen -v | grep 'NGINX_'|awk '{print "\${"$0"}"}' | tr '\n' ','`
replaces="'$replaces'"

file="${base}/templates/${NGINX_TEMPLATE:-simple-proxy}.conf"
echo "using ${file} as template"
envsubst $replaces < ${file} > /etc/nginx/conf.d/default.conf

if [[ ! -z "${NGINX_HEALTHZ}" ]]; then
    envsubst $replaces < "${base}/templates/healthz.conf" > /etc/nginx/conf.d/healthz.conf
fi

envsubst $replaces < "${base}/templates/global.conf" > /etc/nginx/conf.d/global.conf

nginx -g "daemon off;"