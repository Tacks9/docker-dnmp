# 只在 FROM 中生效
ARG NGINX_VERSION
# 基础镜像
FROM nginx:${NGINX_VERSION}

# 【镜像标签】
LABEL maintainer="Tacks <tacks321@qq.com>"
LABEL version="1.0"

# 【当前构建变量】
### ARG 构建环境的环境变量
ARG TZ
ARG NGINX_VERSION
ARG CONTAINER_NGINX_PACKAGE_URL
ARG NGINX_WORK_DIR
ARG NGINX_ETC_DIR

# 【镜像源】
### 默认如下
### http://deb.debian.org
### 将其进行替换为指定镜像源 CONTAINER_NGINX_PACKAGE_URL
RUN if [ $CONTAINER_NGINX_PACKAGE_URL ] ; then \
    sed -i "s/deb.debian.org/${CONTAINER_NGINX_PACKAGE_URL}/g" /etc/apt/sources.list && \
    rm -Rf /var/lib/apt/lists/* && \
    apt-get update \
;fi

# 【包管理器】 
### Ubuntu/Debian Linux 包管理器 apt-get 安装一些软件包
RUN  /bin/bash -c 'apt-get install -y curl && \
    apt-get install -y iputils-ping && \ 
    apt-get install -y net-tools && \
    apt-get install -y telnet'

RUN /bin/bash -c  'echo $NGINX_WORK_DIR \
    ; echo "Hello Dnmp-Nginx"'

# 【默认工作目录】
WORKDIR ${NGINX_WORK_DIR}