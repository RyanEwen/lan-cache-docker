FROM alpine:3.8

ENV NGINX_VERSION 1.13.6

WORKDIR /tmp

RUN set -ex \
  && apk add --no-cache \
    ca-certificates \
    libressl \
    pcre \
    zlib \
    logrotate \
  && apk add --no-cache --virtual .build-deps \
    build-base \
    linux-headers \
    libressl-dev \
    pcre-dev \
    wget \
    zlib-dev \
  && cd /tmp \
  && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar xzf nginx-${NGINX_VERSION}.tar.gz \
  && cd /tmp/nginx-${NGINX_VERSION} \
  && ./configure \
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
    --with-http_slice_module \
    --with-threads \
    --with-file-aio \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && mkdir -p /var/cache/nginx /var/lib/nginx/body \
  && apk del .build-deps \
  && rm -rf /tmp/* /etc/nginx/conf.d/* /etc/nginx/sites-enabled/*

COPY logrotate.conf /etc/logrotate.d/nginx

RUN set -ex \
  && chmod 0644 /etc/logrotate.d/nginx

CMD ["start-nginx.sh"]
