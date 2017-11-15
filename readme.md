# Simple LAN Cache using Docker, Dnsmasq, and NGINX

## Caches the following services for reduced internet traffic and quicker installs:
* Steam
* Origin
* Blizzard
* League of Legends
* ArenaNet (Guild Wars 2)
* Uplay
* Frontier (Elite Dangerous)

The folowing are untested and may require SSL certificate spoofing to work (not covered here).
* Microsoft
* Xbox
* PlayStation
* Hirez
* Epic Games (needs SSL spoofing)

## Setup Instructions
1. Build the docker images and spawn container instances:
    * `docker-compose up -d`
    * Full setup instructions can be found [in the Wiki](https://github.com/RyanEwen/lan-cache-docker/wiki/Quick-Start)

1. Test it out:
    * `nslookup steamcache.cs.steampowered.com <ip-address-of-caching-machine>`
    * Full testing instructions can be found [in the Wiki](https://github.com/RyanEwen/lan-cache-docker/wiki/How-to-test)

1. Direct traffic to the caching server:
    * Configure your router to use your caching server IP for DNS.
    Some routers allow you to change the DNS server IPs on the WAN settings page. Failing that, check the LAN settings page. You can also point machines directly to the caching server individually by changing their individual DNS settings instead.

## How this works
There are 3 docker containers that take care of proxying and caching traffic:
* `dnsmasq`: Runs dnsmasq DNS server to redirect game download traffic to NGINX.
* `nginx`: Runs NGINX web server which is setup to act as an HTTP proxy, caching and serving game downloads.
* `sniproxy`: Runs SNI Proxy which allows HTTPS traffic to pass through to the actual service it's intended for, without decrypting it. This doesn't allow HTTPS to be cached and instead simply prevents HTTPS requests from breaking.

In short: when the machine running these containers is used as a DNS server by other machines, dnsmasq handles DNS requests to redirect traffic to NGINX on the same machine, which caches data to disk and can serve it out to clients.

## Adding or updating services
1. Instructions can be found [in the Wiki](https://github.com/RyanEwen/lan-cache-docker/wiki/Adding-or-updating-services).

## Credits
This is a fork of [OpenSourceLAN's origin-docker](https://github.com/OpenSourceLAN/origin-docker) which I decided to dive deep into and ended up reorganizing quite a bit. Credit is due over there :)
