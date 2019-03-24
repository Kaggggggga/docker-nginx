#!/usr/bin/env bash
set -e

/nginx/scripts/init-config-files.sh
./reload.sh &
nginx -g "daemon off;"