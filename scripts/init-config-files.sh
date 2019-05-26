#!/usr/bin/env bash
set -e

base="/nginx"

init_scripts="${base}/scripts/init.d/*"
for script in $init_scripts; do
    if [ -f $script -a -x $script ]; then
#        echo "start init script: ${script}"
        . $script
    fi
done

nginx_confd_base="/etc/nginx/conf.d"

replaces=`compgen -v | grep 'NGINX_'|awk '{print "\${"$0"}"}' | tr '\n' ','`
replaces="'$replaces'"

if [ ${NGINX_TEMPLATE} != "default" ]; then
    file="${base}/templates/${NGINX_TEMPLATE}.conf"
    if [ ! -f $file ]; then
        echo "NGINX_TEMPLATE($NGINX_TEMPLATE) not found" 1>&2;
        exit 1;
    fi
    echo "using ${file} as template"
    envsubst $replaces < "${file}" > "${nginx_confd_base}/default.conf"
fi

if [[ ! -z "${NGINX_HEALTHZ}" ]]; then
    envsubst $replaces < "${base}/templates/healthz.conf" > "${nginx_confd_base}/healthz.conf"
fi

envsubst $replaces < "${base}/templates/global.conf" > "${nginx_confd_base}/global.conf"

nginx -t
