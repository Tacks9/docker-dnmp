# 只在 FROM 中生效
ARG PHP_VERSION
# 基础镜像
FROM php:${PHP_VERSION}

# 【镜像标签】
LABEL maintainer="Tacks <tacks321@qq.com>"
LABEL version="1.0"

# 【当前构建变量】
### ARG 构建环境的环境变量
ARG TZ
ARG PHP_WORK_DIR
ARG CONTAINER_PHP_PACKAGE_URL
ARG PHP_EXTENSIONS

# 【镜像源】
### 默认如下
### https://dl-cdn.alpinelinux.org/alpine/v3.16/main
### https://dl-cdn.alpinelinux.org/alpine/v3.16/community
### 将其进行替换为指定镜像源 CONTAINER_PHP_PACKAGE_URL
RUN if [ $CONTAINER_PHP_PACKAGE_URL ] ; then \
    sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PHP_PACKAGE_URL}/g" /etc/apk/repositories \
;fi


# 【时区】
RUN apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone


# 【包管理器】 
### Alpine Linux 包管理器 apk 安装一些软件包
### autoconf: 用于生成配置脚本的工具
### build-base: 包含常见的构建工具和库文件 如 make
### linux-headers: 用于构建和编译内核模块的头文件
### libevent-dev: libevent 库的开发文件，为使用 libevent 进行事件驱动编程提供支持
### openldap-dev: OpenLDAP 的开发文件，为编译和开发与 LDAP 相关的应用程序提供支持
### imagemagick-dev: ImageMagick 图像处理库的开发文件，用于在应用程序中进行图像处理操作
RUN apk add --no-cache \
    autoconf \
    build-base \
    linux-headers \
    libevent-dev \
    openldap-dev \
    imagemagick-dev \
    curl

# 【加载目录】
COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions

# 【composer】
RUN chmod +x install-composer.sh \
    && sh install-composer.sh
ENV COMPOSER_HOME=/tmp/composer


# 【extension】
ENV EXTENSIONS=",${PHP_EXTENSIONS},"
ENV MC="-j$(nproc)"
RUN export MC="-j$(nproc)" \
    && chmod +x install-ext.sh \
    && sh install-ext.sh \
    && rm -rf /tmp/extensions

# 【设置用户ID】
### 默认镜像 UID=82 GID=82 ，修改为 1000
### id -u www-data
### id -g www-data
RUN apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data


# 【默认工作目录】
WORKDIR ${PHP_WORK_DIR}