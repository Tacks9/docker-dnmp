# Docker-Dnmp

> PHP Docker Development Environment

## Directory Description

```shell
/
├── services                    Service Build
│   ├── nginx                   Nginx 
│   │   ├── Dockerfile                 Dockerfile
│   │   ├── nginx.conf                 nginx conf
│   │   ├── conf.d/                    conf.d    Domain Name Configuration
│   │   ├── error/                     error     400/50x html
│   │   ├── fastcgi/                   fastcgi   PHP-CGI Configuration
│   │   ├── ssl/                       ssl       HTTPS SSL Certificate
│   ├── php74                   PHP74 
│   │   ├── Dockerfile               Dockerfile
│   │   ├── php-fpm.conf             php-fpm conf
│   │   ├── extensions/              PHP Extension Shell
├── logs                        Service Log
│   ├── nginx                       Nginx Log
│   ├── php74                       PHP74 Log
├── docker-compose.example.yml
├── env.example  
└── www                   
```

## CONTAINER LIST

- php7.4
- nginx


## INIT

```shell
# config init
cp docker-compose.example.yml docker-compose.yml
cp env.example .env

# build image
docker-compose build 

# run container
docker-compose up -d

# restart container
docker-compose restart
```