# A Simple LAN Cache Using Docker

## Reduce internet traffic and increase install speeds for:
* Steam
* Origin
* Uplay
* Blizzard (Including Destiny 2)
* League of Legends
* ArenaNet (Guild Wars 2)
* Frontier (Elite Dangerous)
* Microsoft (Windows Updates)

The folowing are untested and may require SSL certificate spoofing to work (not covered here).
* Xbox
* PlayStation
* Hirez
* Epic Games (needs SSL spoofing to work)

## Quick Start
1. Build the docker images and spawn docker containers:
    * `docker-compose up --build -d`
    * Full setup instructions can be found [in the Wiki](https://github.com/RyanEwen/lan-cache-docker/wiki/Setup-instructions)

1. Test your cache server from another machine:
    * `nslookup steamcontent.com <ip-of-cache-server>`
    * Full testing instructions can be found [in the Wiki](https://github.com/RyanEwen/lan-cache-docker/wiki/How-to-test)

1. Direct network traffic to your cache server:
    * Configure your router to use the cache server as a DNS server.
    Some routers have this setting on WAN settings page. Failing that, check the LAN settings page.
    * Alternatively you can configure individual machines by changing the DNS server address in their network settings.

## How this works
There are 3 docker containers that make up the cache server:
* `dnsmasq`: Uses Dnsmasq DNS server to redirect requests for game downloads to the cache server.
* `nginx`: Uses NGINX web server as an HTTP proxy and to cache HTTP requests for game downloads.
* `sniproxy`: Uses SNI Proxy server as an HTTPS proxy to prevent redirected HTTPS traffic from 404-ing. This traffic cannot be cached so it's simply passed-through without decryption.

## Adding or updating services
* Instructions can be found [in the Wiki](https://github.com/RyanEwen/lan-cache-docker/wiki/Adding-or-updating-services).

## Help
* Check the [Wiki](https://github.com/RyanEwen/lan-cache-docker/wiki) first.
* Please report issues or request help [here](https://github.com/RyanEwen/lan-cache-docker/issues)

## Credits
This started as a fork of [OpenSourceLAN's origin-docker](https://github.com/OpenSourceLAN/origin-docker) which I decided to dive deep into and ended up reorganizing quite a bit. Credit is due over there :)
