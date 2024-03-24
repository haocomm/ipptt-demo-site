
# cloudflared-tunnel-webfront
```
git clone https://github.com/haocomm/ipptt-demo-site.git

cd cloudflare

docker run -v ${PWD}/config:/root/.cloudflared msnelling/cloudflared cloudflared tunnel login

docker run -v ${PWD}/config:/etc/cloudflared msnelling/cloudflared cloudflared tunnel create <name tunnel>
```

```
echo 'tunnel: uuid tunnel' > config/config.yaml
```
## Cloudflared
```
docker-compose up -d
docker-compose logs -f
```

## Check your tunnel is visible on the Cloudflare Zero Trust Dashboard ->(https://dash.teams.cloudflare.com/)
Access > Tunnels

## Cloudflared
```
nano cloudflare-tunnel-wordpress/config/config.yml
ingress:
        - hostname: <site url>
          service: http://nginx-webfront:80
        - service: http_status:404
```
```
docker-compose restart cloudflared
```
## Change the DNS settings of your domain
```
Add  CNAME record to <UUID of your tunnel>.cfargotunnel.com
```

## Deploy Webfront site
```
cd cloudflare/demo-tk.haocomm.com

docker-compose up -d
```

## Deploy IPPTT STACK
```
docker-compose up -d
```