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
│   ├── grafana                 Grafana 
│   │   ├── grafana.ini                 grafana.ini
├── logs                        Service Log
│   ├── nginx                       Nginx Log
│   ├── php74                       PHP74 Log
│   ├── mysql                       Mysql Log
│   ├── redis                       Redis Log
├── data                        Service Data
│   ├── mysql                       Mysql Data
│   ├── redis                       Redis Data
│   ├── kafka                       Kafka Data
│   ├── etcd                        Etcd Data
│   ├── influxdb                    InfluxDB Data
│   ├── grafana                     Grafana Data
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
- etcd
- influxdb
- grafana


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

### etcd

```shell
# come in etcd
$ docker exec -it  dnmp-etcd-node1 /bin/bash

# version etcd & api
$ etcdctl version

# etcd show cluster nodes
$ etcdctl member list

$ etcdctl member list --write-out=table

# etcd check the health status of etcd cluster nodes
$ etcdctl endpoint health

$ etcdctl endpoint health  --endpoints http://etcd-node1:2379,http://etcd-node2:2379,http://etcd-node3:2379

$ etcdctl endpoint health  --endpoints http://etcd-node1:2379,http://etcd-node2:2379,http://etcd-node3:2379 --write-out=table


# etcd add key-value
$ etcdctl put name test

# etcd get key
$ etcdctl get name

# etcd delete key
$ etcdctl del name

# etcd watch key
$ etcdctl watch name
```

### influxdb

```shell
# come in influxdb
$ docker exec -it  dnmp-influxdb /bin/bash

# influxdb show bucket list
$ influx bucket list

# influxdb create bucket 
$ influx bucket create --name test --org tacks


# influxdb add point-data to bucket (time unit is second)
$ influx write --bucket test --precision s "beijing,unit=temperature avg=8.8,max=12.0 1699522715"

# date 
$ date -u +"%Y-%m-%dT%H:%M:%SZ"

# influxdb search
$ influx query '
from(bucket: "test")
    |> range(start: 2023-11-08T09:40:45Z, stop: 2023-11-09T09:40:45Z)
    |> filter(fn: (r) => r._measurement == "beijing")
    |> filter(fn: (r) => r._field== "max" or r._field == "avg")
'

# influxdb delete point-data with time
$ influx delete --bucket test --start 2023-11-08T09:40:45Z --stop 2023-11-09T09:40:45Z 

# influxdb delete bucket
$ influx bucket delete -n test -o tacks


# come in influxdb Interactive Command Line 
$ influx v1 shell

# [influxdb sql] show bucket list
$ show databases

# [influxdb sql] use a bucket
$ use test

# [influxdb sql] show measurement list
$ show measurements;

# [influxdb sql] select measurement points-data
$ select * from "beijing" limit 10;

# [influxdb sql] show tag list
$ show tag keys;

# [influxdb sql] show fields
$ show field keys;

# [influxdb sql] show data storage policy list
$ show retention policies;
```
