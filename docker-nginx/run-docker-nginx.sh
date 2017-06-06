#!/bin/bash

docker rm -f lan-cache-nginx
docker run -d -p 80:80 \
    -v /data/cache:/cache \
    -v /data/logs:/var/log/nginx \
    -v /data/conf:/etc/nginx/conf.d \
    -v /data/nginx.conf:/etc/nginx/nginx.conf \
    --restart=unless-stopped \
    --name lan-cache-nginx \
    lan-cache-nginx
