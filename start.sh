#!/bin/bash
mkdir -p /origin/data /origin/logs

docker run -it --rm -p 80:80 -v /steam:/origin/data -v /var/log/nginx:/origin/logs cache
