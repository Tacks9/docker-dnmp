#!/bin/sh
## 【composer 安装脚本】


## 参考
## https://getcomposer.org/
## https://mirrors.aliyun.com/composer/composer.phar
## Composer 最新版本需要 PHP 7.2.5 才能运行

# 方法一 【composer】
## 采用国内源
curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer

# 方法二 【composer】
## 下载
# curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# 方法三 【composer】 
## 多阶段构建
# COPY --from=composer/composer /usr/bin/composer /usr/bin/composer