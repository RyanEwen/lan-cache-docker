#!/bin/bash

wget http://nginx.org/download/nginx-1.13.1.tar.gz
tar -xf nginx*
cd nginx*

# Configure options taken from the current Ubuntu 12.04 `nginx-light` rules
# with the addition of the slice module, and the removal of a no-longer-valid one
./configure \
    --prefix=/usr \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
    --http-log-path=/var/log/nginx/access.log \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --lock-path=/var/lock/nginx.lock \
    --pid-path=/var/run/nginx.pid \
    --with-http_gzip_static_module \
    --with-http_ssl_module \
    --with-ipv6 \
    --without-http_browser_module \
    --without-http_geo_module \
    --without-http_limit_req_module \
    --without-http_memcached_module \
    --without-http_referer_module \
    --without-http_scgi_module \
    --without-http_split_clients_module \
    --with-http_stub_status_module \
    --without-http_ssi_module \
    --without-http_userid_module \
    --without-http_uwsgi_module \
    --with-http_slice_module

make -j 8
make install
