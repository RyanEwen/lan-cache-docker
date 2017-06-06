#!/bin/bash
sudo rm -rf /data && sudo ln -s `pwd`/data /data
(cd docker-nginx && docker build -t lan-cache-nginx . && ./run-docker-nginx.sh)
(cd docker-dnsmasq && docker build -t lan-cache-dnsmasq . && ./run-docker-dnsmasq.sh)
(cd docker-sniproxy && docker build -t lan-cache-sniproxy . && ./run-docker-sniproxy.sh)
