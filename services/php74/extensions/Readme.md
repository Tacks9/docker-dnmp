# Extension

## PHP7.4 php-fpm-alpine 镜像默认安装的扩展

```php
Core       = 7.4.33 # 基础核心扩展 
PDO        = 7.4.33 # PHP 数据对象，用于与不同类型的数据库进行交互
Phar       = 7.4.33 # 用于处理 PHP 归档文件 phar
Reflection = 7.4.33 # 核心扩展，提供反射功能
SPL        = 7.4.33 # 一套标准化的数据结构和算法组件的实现，包含迭代器、异常处理、数据结构、自动加载、文件处理
SimpleXML  = 7.4.33 # SimpleXML 扩展是一个基于 libxml 的扩展，用于在 PHP 中解析和操作 XML 数据
cli_server = 7.4.33 # 提供简易的命令行服务器
ctype      = 7.4.33 # 用于字符类型检查和操作
curl       = 7.4.33 # 用于与服务器或其他资源进行网络通信
date       = 7.4.33 # Date PHP 扩展，处理日期和时间
dom        = 20031129 # 用于处理 XML 文档
fileinfo   = 7.4.33 # 根据文件内容返回文件信息
filter     = 7.4.33 # 提供了一组函数和过滤器，用于过滤和校验输入数据
ftp        = 7.4.33 # 用于与远程 FTP（文件传输协议）服务器进行交互的扩展 连接到 FTP 服务器、上传和下载文件、创建和删除目录、列出目录内容
hash       = 7.4.33 # 提供了一组函数，可以在 PHP 脚本中执行各种哈希算法，比如 MD5、SHA-1、SHA-256
iconv      = 7.4.33 # 用于字符编码之间的转换的扩展
json       = 7.4.33 # 用于 JSON 数据的编码和解码
libxml     = 7.4.33 # 用于操作 XML 数据的扩展。它提供了一组函数和类，用于解析、创建、操作和验证 XML 文档
mbstring   = 7.4.33 # 用于多字节字符操作和 Unicode 支持
mysqlnd    = mysqlnd 7.4.33 #  MySQL Native Driver 高性能、低内存消耗的方式来连接和操作 MySQL 数据库
openssl    = 7.4.33 # 用于与 OpenSSL 加密库进行交互的扩展
pcre       = 7.4.33 # 用于支持正则表达式操作的扩展
pdo_sqlite = 7.4.33 # PDO 通用接口，用于在 PHP 中与 SQLite 数据库进行交互的扩展
posix      = 7.4.33 # 提供了与 POSIX 操作系统 API 的接口
readline   = 7.4.33 # 用于读取用户输入
session    = 7.4.33 # 提供会话能力
sodium     = 7.4.33 # 用于密码学操作和数据加密
sqlite3    = 7.4.33 # 用于在 PHP 中与 SQLite 3 数据库进行交互的扩展
standard   = 7.4.33 # 核心扩展，用于提供基本功能和常用函数，如字符串、数组、文件、日期、输入输出等处理
tokenizer  = 7.4.33 # 分词的扩展 提供了一组函数来将字符串按照指定的规则进行分割和切分
xml        = 7.4.33 # 用于处理 XML 数据
xmlreader  = 7.4.33 # 用于逐行读取 XML 文档
xmlwriter  = 7.4.33 # 用于生成 XML 文件
zlib       = 7.4.33 # 用于压缩和解压缩的扩展

```

## 支持

```shell
PHP_EXTENSIONS=bcmath,pdo_mysql,mysqli,opcache,sockets,pcntl,event,shmop,sysvmsg,sysvsem,sysvshm,gd,curl,mbstring,redis,mongodb,rdkafka,memcached,psr,yaf,yaml,xdebug
```

```shell
Core=7.4.33
PDO=7.4.33
Phar=7.4.33
Reflection=7.4.33
SPL=7.4.33
SimpleXML=7.4.33
Zend OPcache=7.4.33
bcmath=7.4.33
cli_server=7.4.33
ctype=7.4.33
curl=7.4.33
date=7.4.33
dom=20031129
event=3.0.8
fileinfo=7.4.33
filter=7.4.33
ftp=7.4.33
gd=7.4.33
hash=7.4.33
iconv=7.4.33
json=7.4.33
libxml=7.4.33
mbstring=7.4.33
memcached=3.2.0
mongodb=1.16.1
mysqli=7.4.33
mysqlnd=mysqlnd 7.4.33
openssl=7.4.33
pcntl=7.4.33
pcre=7.4.33
pdo_mysql=7.4.33
pdo_sqlite=7.4.33
posix=7.4.33
psr=1.2.0
rdkafka=6.0.3
readline=7.4.33
redis=5.3.7
session=7.4.33
shmop=7.4.33
sockets=7.4.33
sodium=7.4.33
sqlite3=7.4.33
standard=7.4.33
sysvmsg=7.4.33
sysvsem=7.4.33
sysvshm=7.4.33
tokenizer=7.4.33
xdebug=3.1.5
xml=7.4.33
xmlreader=7.4.33
xmlwriter=7.4.33
yaf=3.3.5
yaml=2.2.3
zlib=7.4.33
```