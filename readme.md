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

## create network

```
sudo docker network create --driver bridge j2ray
```



## v2ray

```shell
sudo docker build -t jeromesu/v2ray .
```

```shell
sudo docker run --rm --name=v2ray --net j2ray -itd jeromesu/v2ray
```



## nginx

```shell
sudo docker run \
  --rm \
  --name nginx \
  --label=sh.acme.autoload.domain=bonjour.jeromesu.com \
  -v "$PWD/web":/usr/share/nginx/html \
  -v "$PWD/config/conf.d":/etc/nginx/conf.d \
  -v "$PWD/config/certs":/etc/nginx/certs \
  -v "$PWD/log":/var/log/nginx \
	--net j2ray \
  -p 80:80 \
  -p 443:443 \
  -d \
  nginx
```

### certificate

```
openssl req -new -key key.pem -out full.csr
openssl x509 -req -in full.csr -signkey key.pem -out full.pem
```



## acme

install

```shell
curl  https://get.acme.sh | sh
source ~/.bashrc
```

generate certificate

```shell
acme.sh --set-default-ca  --server  letsencrypt
Namesilo_Key="a39d759ee947f08343ae7a104" acme.sh --issue --dns dns_namesilo -d bonjour.jeromesu.com --dnssleep 180
```

deploy certificate

```shell
acme.sh --installcert -d bonjour.jeromesu.com   \
        --key-file   ~/J2ray/nginx/config/certs/bonjour_jeromesu_com/key.pem \
        --fullchain-file ~/J2ray/nginx/config/certs/bonjour_jeromesu_com/full.pem \
        --ecc
```

