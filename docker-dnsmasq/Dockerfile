FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y dnsmasq

ADD dnsmasq.sh /usr/bin/
RUN echo "conf-dir=/etc/dnsmasq.d/,*.conf" >> /etc/dnsmasq.conf
CMD ["dnsmasq.sh"]
