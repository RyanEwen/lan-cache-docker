#!/bin/bash

get_ip() {
  interface=$(ip route | grep default | awk '{print $(NF)}')
  ip addr show dev $interface | grep 'inet ' | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | head -n 1
}

if [[ -z $HOST_IP ]]; then
  HOST_IP=$(get_ip)

  if [[ -n $HOST_IP ]]; then
    echo "\$HOST_IP not set, autodetected as $HOST_IP"
    export HOST_IP=$HOST_IP
  else
    echo "\$HOST_IP not set and couldn't be autodetected. Exiting."
    exit 1
  fi
fi

docker rm -f lan-cache-dnsmasq
docker run -it -d -p 53:53 -p 53:53/udp \
  -e "HOST_IP=$HOST_IP" \
  -v /data/dnsmasq-template.conf:/dnsmasq-template.conf \
  --restart=unless-stopped \
  --name lan-cache-dnsmasq \
  lan-cache-dnsmasq
