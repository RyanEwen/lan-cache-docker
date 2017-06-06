FROM ubuntu:latest

RUN apt-get update && apt-get install -y build-essential libssl-dev libpcre3 libpcre3-dev zlib1g zlib1g-dev
RUN apt-get install -y wget

RUN mkdir /build
WORKDIR /build
ADD build-nginx.sh /build/build-nginx.sh
RUN /build/build-nginx.sh

RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/sites-enabled/*
RUN mkdir -p /var/lib/nginx/body
RUN mkdir -p /var/lib/nginx/fastcgi

CMD nginx -g "daemon off;" -c /etc/nginx/nginx.conf
