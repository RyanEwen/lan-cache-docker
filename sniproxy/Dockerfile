FROM ubuntu

RUN apt-get update 
RUN apt-get install -y git build-essential libudns0 libudns-dev libpcre3 libpcre3-dev libev4 libev-dev devscripts automake libtool autoconf autotools-dev cdbs debhelper dh-autoreconf dpkg-dev gettext  pkg-config fakeroot 

RUN git clone https://github.com/dlundquist/sniproxy.git 
WORKDIR /sniproxy
RUN ./autogen.sh && ./configure && make && make install
ADD sniproxy.conf /etc/sniproxy.conf
CMD sniproxy -f
