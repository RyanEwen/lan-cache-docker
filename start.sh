#!/bin/bash
mkdir -p /data/data /data/logs
docker rm -f cache

docker run --name cache -d --restart=always -p 80:80 -v /steam/data:/cache -v /steam/data/logs:/var/log/nginx cache
