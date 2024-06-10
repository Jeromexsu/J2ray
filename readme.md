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

```
docker run --rm -d -p 10086:10086 --name=v2ray jeromesu/v2ray
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



## nginx

```Shell
docker container run \
  --rm \
  --name nginx \
  --volume "$PWD/html":/usr/share/nginx/html \
  --volume "$PWD/conf":/etc/nginx \
  --label=sh.acme.autoload.domain=bonjour.jeromesu.com \
  -p 80:80 \
  -p 443:443 \
  -d \
  nginx
```