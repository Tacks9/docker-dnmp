# Docker-Dnmp

> PHP Docker Development Environment

## Directory Description

```shell
/
├── services                    Service Build
│   ├── mysql                   Mysql 
│   │   ├── Dockerfile                 Dockerfile
│   │   ├── conf.d/                    conf.d    mysql.cnf
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
│   ├── redis                   Redis 
│   │   ├── Dockerfile                 Dockerfile
│   │   ├── redis.conf                 redis.conf
├── logs                        Service Log
│   ├── nginx                       Nginx Log
│   ├── php74                       PHP74 Log
│   ├── mysql                       Mysql Log
│   ├── redis                       Redis Log
├── data                        Service Data
│   ├── mysql                       Mysql Data
│   ├── redis                       Redis Data
│   ├── kafka                       Kafka Data
├── docker-compose.example.yml
├── env.example  
└── www                   
```

## CONTAINER LIST

- php7.4
- nginx
- mysql
- redis
- kafka


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

## CMD

### kafka

```shell
# java version
$ java -version
openjdk version "17.0.8" 2023-07-18 LTS
OpenJDK Runtime Environment (build 17.0.8+7-LTS)
OpenJDK 64-Bit Server VM (build 17.0.8+7-LTS, mixed mode, sharing)

# kafka version
$ kafka-broker-api-versions.sh --version --bootstrap-server dnmp-kafka-node1:9092 dnmp-kafka-node2:9092 dnmp-kafka-node3:9092 

# kafka bin
$ ls /opt/bitnami/kafka/bin

# kafka create topic (3 Replica & 5 Partition)
$ kafka-topics.sh --create --topic test --replication-factor 3 --partitions 5 --bootstrap-server kafka-node1:9092 kafka-node2:9092 kafka-node3:9092

# kafka show topic list
$ kafka-topics.sh --list  --bootstrap-server dnmp-kafka-node1:9092 dnmp-kafka-node2:9092 dnmp-kafka-node3:9092

# kafka show topic describe
$ kafka-topics.sh --describe --topic test  --bootstrap-server kafka-node1:9092 kafka-node2:9092 kafka-node3:9092

# kafka open producer (producer client => --broker-list)
$ kafka-console-producer.sh --topic test --broker-list kafka-node1:9092 kafka-node2:9092 kafka-node3:9092

# kafka open consumer (consumer client => --bootstrap-server)
$ kafka-console-consumer.sh --topic test --bootstrap-server kafka-node1:9092 kafka-node2:9092 kafka-node3:9092 
```
