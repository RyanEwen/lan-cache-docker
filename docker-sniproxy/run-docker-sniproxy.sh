#!/bin/bash

docker rm -f lan-cache-sniproxy
docker run -d -p 443:443 \
    --restart=unless-stopped \
    --name lan-cache-sniproxy \
    lan-cache-sniproxy
