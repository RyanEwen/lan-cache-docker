#!/bin/bash
mkdir -p /data/data /data/logs

docker run -it --rm -p 80:80 -v /steam:/data/data -v /var/log/nginx:/data/logs cache
