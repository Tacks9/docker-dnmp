# Mysql


## Mysql8 设置宿主机远程连接

```shell
# 1、进入 Mysql 容器，连接 Mysql
mysql -u root -p

# 2、选择 Mysql 数据库
use mysql ;

# 3、查看当前 root 用户的相关信息
mysql> select host, user, authentication_string, plugin from user;
+-----------+------------------+------------------------------------------------------------------------+-----------------------+
| host      | user             | authentication_string                                                  | plugin                |
+-----------+------------------+------------------------------------------------------------------------+-----------------------+
| localhost | root             |                                                                        | caching_sha2_password |
| localhost | mysql.infoschema | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password |
| localhost | mysql.session    | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password |
| localhost | mysql.sys        | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password |
+-----------+------------------+------------------------------------------------------------------------+-----------------------+


# 4、修改 root 为远程访问
mysql> update user set host='%' where user='root';
Query OK, 0 rows affected (0.00 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql> select host, user, authentication_string, plugin from user;
+-----------+------------------+------------------------------------------------------------------------+-----------------------+
| host      | user             | authentication_string                                                  | plugin                |
+-----------+------------------+------------------------------------------------------------------------+-----------------------+
| %         | root             | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9                              | mysql_native_password |
| localhost | mysql.infoschema | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password |
| localhost | mysql.session    | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password |
| localhost | mysql.sys        | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password |
+-----------+------------------+------------------------------------------------------------------------+-----------------------+

# 5、置密码登录方式
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';

# 6、执行两次权限设置
mysql> GRANT ALL ON *.* TO 'root'@'%';
ERROR 1410 (42000): You are not allowed to create a user with GRANT
mysql> GRANT ALL ON *.* TO 'root'@'%';
Query OK, 0 rows affected (0.01 sec)

# 7、刷新
mysql> flush privileges;
Query OK, 0 rows affected (0.01 sec)
```