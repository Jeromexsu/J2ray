## docker

### install

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### start

```
sudo systemctl start docker
```

### verify

```
sudo docker run --rm hello-world
```



## v2ray

```shell
docker build -t jeromesu/v2ray .
```

```shell
sudo docker run --rm -itd -p 10086:10086 --name=v2ray jeromesu/v2ray
```



## nginx

```shell
docker container run \
  --rm \
  --name nginx \
  -v "$PWD/web":/usr/share/nginx/html \
  -v "$PWD/config/conf.d":/etc/nginx/conf.d \
  -v "$PWD/log":/var/log/nginx \
  --label=sh.acme.autoload.domain=bonjour.jeromesu.com \
  -p 80:80 \
  -p 443:443 \
  -d \
  nginx
```



## acme

run acme as daemon

```shell
docker run --rm -itd \
-v acme:/acme.sh \
--name=acme.sh \
-e Namesilo_key="a39d759ee947f08343ae7a104" \
neilpang/acme.sh daemon
```

generate certificate

```shell
docker exec acme.sh --set-default-ca  --server  letsencrypt
docker exec acme.sh --issue --dns dns_namesilo -d bonjour.jeromesu.com --dnssleep 300
```

