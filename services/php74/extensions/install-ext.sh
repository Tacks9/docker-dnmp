#!/bin/sh

echo
echo "============================================"
echo "Install extensions from   : install-ext.sh"
echo "PHP version               : ${PHP_VERSION}"
echo "Extra Extensions          : ${PHP_EXTENSIONS}"
echo "Multicore Compilation     : ${MC}"
echo "Container package url     : ${CONTAINER_PHP_PACKAGE_URL}"
echo "Work directory            : ${PWD}"
echo "============================================"
echo


if [ "${PHP_EXTENSIONS}" != "" ]; then
    echo "---------- Install general dependencies ----------"
    apk add --no-cache autoconf g++ libtool make curl-dev libxml2-dev linux-headers build-base openssl
fi

############################################################# 【docker-php-ext-install】 安装扩展

if [ -z "${EXTENSIONS##*,bcmath,*}" ]; then
    echo "---------- Install bcmath ----------"
	docker-php-ext-install ${MC} bcmath
fi

if [ -z "${EXTENSIONS##*,pdo_mysql,*}" ]; then
    echo "---------- Install pdo_mysql ----------"
    docker-php-ext-install ${MC} pdo_mysql
fi

if [ -z "${EXTENSIONS##*,mysqli,*}" ]; then
    echo "---------- Install mysqli ----------"
	docker-php-ext-install ${MC} mysqli
fi

if [ -z "${EXTENSIONS##*,opcache,*}" ]; then
    echo "---------- Install opcache ----------"
    docker-php-ext-install opcache
fi

if [ -z "${EXTENSIONS##*,sockets,*}" ]; then
    echo "---------- Install sockets ----------"
	docker-php-ext-install ${MC} sockets
fi

if [ -z "${EXTENSIONS##*,pcntl,*}" ]; then
    echo "---------- Install pcntl ----------"
	docker-php-ext-install ${MC} pcntl
fi



if [ -z "${EXTENSIONS##*,shmop,*}" ]; then
    echo "---------- Install shmop ----------"
	docker-php-ext-install ${MC} shmop
fi

if [ -z "${EXTENSIONS##*,sysvmsg,*}" ]; then
    echo "---------- Install sysvmsg ----------"
	docker-php-ext-install ${MC} sysvmsg
fi

if [ -z "${EXTENSIONS##*,sysvsem,*}" ]; then
    echo "---------- Install sysvsem ----------"
	docker-php-ext-install ${MC} sysvsem
fi

if [ -z "${EXTENSIONS##*,sysvshm,*}" ]; then
    echo "---------- Install sysvshm ----------"
	docker-php-ext-install ${MC} sysvshm
fi
 

if [ -z "${EXTENSIONS##*,curl,*}" ]; then
    echo "---------- Install curl ----------"
	docker-php-ext-install ${MC} curl
fi

if [ -z "${EXTENSIONS##*,mbstring,*}" ]; then
    echo "---------- Install mbstring ----------"
	docker-php-ext-install ${MC} mbstring
fi



############################################################# 【PECL】 安装扩展

# 说明
#### printf "\n" | pecl install redis 这样做的目的可能是为了避免在安装过程中需要手动确认选项或按下回车键

# https://pecl.php.net/package/redis 5.3.7
if [[ -z "${EXTENSIONS##*,redis,*}" ]]; then
    echo "---------- Install redis ----------"
    printf "\n" | pecl install redis
    docker-php-ext-enable redis
fi

# https://pecl.php.net/package/mongodb 1.16.1
if [[ -z "${EXTENSIONS##*,mongodb,*}" ]]; then
    echo "---------- Install mongodb ----------"
    printf "\n" | pecl install mongodb
    docker-php-ext-enable mongodb
fi

# https://pecl.php.net/package/rdkafka 6.0.3
if [[ -z "${EXTENSIONS##*,rdkafka,*}" ]]; then
    echo "---------- Install rdkafka ----------"
    apk add librdkafka-dev
    printf "\n" | pecl install rdkafka
    docker-php-ext-enable rdkafka
fi

if [[ -z "${EXTENSIONS##*,psr,*}" ]]; then
    echo "---------- Install psr ----------"
    printf "\n" | pecl install psr
    docker-php-ext-enable psr
fi

# https://pecl.php.net/package/yaf 3.3.5
if [ -z "${EXTENSIONS##*,yaf,*}" ]; then
    echo "---------- Install yaf ----------"
    printf "\n" | pecl install yaf
    docker-php-ext-enable yaf
fi

if [[ -z "${EXTENSIONS##*,yaml,*}" ]]; then
    echo "---------- Install yaml ----------"
    apk add --no-cache yaml-dev
    printf "\n" | pecl install yaml
    docker-php-ext-enable yaml
fi

# https://pecl.php.net/package/xdebug 3.1.5
# https://xdebug.org/docs
if [[ -z "${EXTENSIONS##*,xdebug,*}" ]]; then
    echo "---------- Install xdebug ----------"
    printf "\n" | apk add php7-pecl-xdebug
    printf "\n" | pecl install xdebug-3.1.5
    # PHP7.4 可以使用 3.1.5
    # PHP8 可以使用更高的 3.2.2
    docker-php-ext-enable xdebug
fi

#############################################################  安装扩展 需要额外配置环境

if [ -z "${EXTENSIONS##*,gd,*}" ]; then
    echo "---------- Install gd ----------"
    apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev \
        && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
        && docker-php-ext-install ${MC} gd
fi
 

# https://pecl.php.net/package/memcached 3.2.0
if [[ -z "${EXTENSIONS##*,memcached,*}" ]]; then
    echo "---------- Install memcached ----------"
    apk add --no-cache libmemcached-dev zlib-dev pcre-dev
    printf "\n" | pecl install memcached
    docker-php-ext-enable memcached
fi


# https://pecl.php.net/package/swoole
if [[ -z "${EXTENSIONS##*,swoole,*}" ]]; then
    echo "---------- Install swoole ----------"
    apk add --no-cache libstdc++
    # swoole-4.8 版本需要 php-7.2 或更高版本
    # swoole-5.0 版本需要 php-8.0 或更高版本
    printf "\n" | pecl install swoole-4.8.13
    docker-php-ext-enable swoole
fi


############################################################# 【PECL】 安装扩展，有依赖关系的

# https://pecl.php.net/package/event
if [[ -z "${EXTENSIONS##*,event,*}" ]]; then
    echo "---------- Install event ----------"
    apk add --no-cache libevent-dev 
    export is_sockets_installed=$(php -r "echo extension_loaded('sockets');")

    if [[ "${is_sockets_installed}" = "" ]]; then
        echo "---------- event is depend on sockets, install sockets first ----------"
        docker-php-ext-install sockets
    fi

    echo "---------- Install event again ----------"
    # --ini-name 配置文件名，由于要先加载 sockets ，所以重命名 event.ini 放在后面
    pecl install event-3.0.8 && docker-php-ext-enable --ini-name event.ini event 
fi


