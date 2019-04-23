#!/usr/bin/env bash
set -e

/nginx/scripts/init-config-files.sh
/nginx/reload.sh &
nginx -g "daemon off;"