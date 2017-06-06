# Simple LAN Cache using Docker and NGINX

## Caches the following services for reduced internet traffic and quicker installs:
* Steam
* Origin
* Blizzard
* League of Legends

Some of the folowing may require SSL certificate spoofing to work, and come untested. Please test the following in your environment before relying on them.
* Sony (PS4)
* Microsoft
* Hirez
* Epic Games: (not tested, needs custom SSC)

## Quick Start (Linux)
1. Install Docker if you don't have it:

    ```
    curl -sSL https://get.docker.com | sudo bash
    ```

1. Clone this repo onto a volume with lots of storage space:

    ```
    git clone https://github.com/RyanEwen/lan-cache-docker.git
    ```

1. Build docker images and spawn containers:

    ```
    cd lan-cache-docker
    sudo ./setup.sh
    ```

    The containers will start up automatically at boot, unless manually stopped.

1. Test (optional but recommended). See `How to test` below.

1. Direct traffic to the caching server:
    * Set your router to use your caching server IP for DNS.
    Some routers allow you to change the DNS server IPs on the WAN settings page. Failing that, check the LAN settings page. You can also point machines directly to the caching server individually by changing their DNS settings instead.

## How to test
* Point a single machine to use the caching server by setting the DNS server IP to the caching server IP.
* Flush the DNS cache (use `ipconfig /flushdns` on Windows)
* Test DNS using `nslookup`:
    ```
    C:\Users\Ryan> nslookup steampowered.com
    Server:  UnKnown
    Address:  192.168.100.205

    Non-authoritative answer:
    Name:    steampowered.com
    Address:  96.7.203.235
    ```

    You should see your caching server IP followed by the steampowered.com IP. The caching machine handles the DNS request but does not cache that URL so the original IP is returned.

    ```
    C:\Users\Ryan> nslookup steamcache.cs.steampowered.com
    Server:  UnKnown
    Address:  192.168.100.205

    Name:    steamcache.cs.steampowered.com
    Address:  192.168.100.205
    ```

    You should see your caching server IP listed twice this time. The caching machine handles the DNS request as well as the caching that URL, to the caching machine IP is returned.

* Test caching by downloading a game and watching the logs and cache directories:
    * Use `ll /data/logs/` from the caching machine to check if the logs are filling up. You should see sizes increase as traffic is handled.
    * Use `du -h -d 1 /data/cache` from the caching machine to see the actual size of each cache.

* Uninstall and redownload the game. You should see it download much quicker this time, without much (if any) internet traffic.

## How this works
There are 3 docker images & containers:
* `lan-cache-dnsmasq`: Uses Dnsmasq to redirect game download traffic to the local machine.
* `lan-cache-nginx`: Uses NGINX which is setup to act as a web proxy, caching game downloads on the local machine.
* `lan-cache-sniproxy`: Uses SNI Proxy which allows HTTPS traffic to pass through to the cached services without decrypting it.

## Updating service URLs to cache
1. Update the Dnsmasq conf file (`data/dnsmasq-template.conf`) with the new URLs to be handled by the caching machine.
1. Update the approriate NGINX conf (`data/conf/<relevant-service>.conf`) with the same URLs to cache.
1. Recreate the containers to pull in the changed conf files (doesn't remove cache or rebuild the docker images):
    ```
    (cd docker-dnsmasq && sudo ./run-docker-dnsmasq.sh)
    (cd docker-nginx && sudo ./run-docker-nginx.sh)
    ```

## Adding a new service to cache
1. Update the Dnsmasq conf file (`data/dnsmasq-template.conf`) with the new URLs to be handled by the caching machine.
1. Create a new NGINX conf (`data/conf/<new-service>.conf`) with the same URLs to cache. I suggest using `origin.conf` as a template.
1. Create a new cache subdirectory (`data/cache/<new-service>`) and make sure the `proxy_cache_path` setting in your new NGINX conf matches.
1. Recreate the containers to pull in the changed conf files (doesn't remove cache or rebuild the docker images):
    ```
    (cd docker-dnsmasq && sudo ./run-docker-dnsmasq.sh)
    (cd docker-nginx && sudo ./run-docker-nginx.sh)
    ```

## Credits
This is a fork of [OpenSourceLAN's origin-docker](https://github.com/OpenSourceLAN/origin-docker) which I decided to dive deep into and ended up reorganizing quite a bit. Credit is due over there :)
