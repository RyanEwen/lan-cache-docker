FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y dnsmasq

ADD dnsmasq.conf /etc/dnsmasq.d/custom-zones.conf
RUN echo "conf-dir=/etc/dnsmasq.d/,*.conf" >> /etc/dnsmasq.conf
CMD dnsmasq --no-daemon
