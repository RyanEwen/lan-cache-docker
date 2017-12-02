#!/bin/sh

# Start logrotate cron
crond

exec nginx -g "daemon off;" -c /etc/nginx/nginx.conf
