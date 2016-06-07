# LAN Cache in a docker container

Simply expose this container on port 80, and point a bunch of domains to this server's IP address, 
and you get a fully operational LAN cache. Hooray!

```
Steam:
*.cs.steampowered.com
content[1-9].steampowered.com

Blizzard:
dist.blizzard.com.edgesuite.net
llnw.blizzard.com
dist.blizzard.com
blizzard.vo.llnwd.net
blzddist*.akamaihd.net

League of Legends:
l3cdn.riotgames.com

Origin:
origin-a.akamaihd.net

Wargaming.net:
dl.wargaming.net
dl2.wargaming.net
wg.gcdn.co
```
*Warning*: some services (eg, when downloading the Origin client) require HTTPS access to the 
hosts that we are hijacking. To avoid connectivity issues, you will need to run an 
[SNI proxy](https://github.com/dlundquist/sniproxy) to enable pass through of HTTPS traffic. 

You can build and run the sniproxy container in the `sniproxy` directory to achieve this. 

```
cd sniproxy
docker build -t sniproxy .
docker run --name sniproxy -p 443:443 sniproxy
```

