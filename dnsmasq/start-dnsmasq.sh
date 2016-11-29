#!/bin/bash

[[ -n $HOST_IP ]] || (echo "\$HOST_IP not set. Cannot proceed :(" && exit 1)

[[ -f /etc/dnsmasq.d/custom-zones.conf ]] || (cat /dnsmasq-template.conf | sed "s/IP_HERE/$HOST_IP/" > /etc/dnsmasq.d/custom-zones.conf)

exec dnsmasq --no-daemon


