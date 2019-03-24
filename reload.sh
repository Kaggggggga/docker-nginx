set -e

if [ ! -z "${NGINX_RELOAD_INTERVAL}" ]; then
    while sleep ${NGINX_RELOAD_INTERVAL}; do
        if [ -e /var/run/nginx.pid ] && kill -0 `cat /var/run/nginx.pid`; then
            /nginx/scripts/init-config-files.sh
            nginx -s reload
        else
            echo "nginx is not running"
        fi
    done
fi