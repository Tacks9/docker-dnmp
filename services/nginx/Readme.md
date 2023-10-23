# Nginx


## 生成临时 SSL 证书文件

```shell
# 1、使用以下命令生成私钥文件（.key文件）：
openssl genrsa -out yourdomain.key 2048

# 2、使用以下命令生成证书签名请求文件（.csr文件），其中yourdomain.com应替换为您的域名：
openssl req -new -key yourdomain.key -out yourdomain.csr

# 3、自签名证书，可以使用以下命令生成自签名证书（.crt文件），其中365表示证书有效期为365天：
openssl x509 -req -days 365 -in yourdomain.csr -signkey yourdomain.key -out yourdomain.crt

# 4、将生成的证书文件（.crt）和私钥文件（.key）上传到服务器的某个目录中，例如/etc/nginx/ssl/
cp  yourdomain.key /etc/nginx/ssl/
cp  yourdomain.crt /etc/nginx/ssl/

# 5、配置nginx
ssl_certificate /etc/nginx/ssl/yourdomain.crt;
ssl_certificate_key /etc/nginx/ssl/yourdomain.key;

# 6、检查配置然后重启
nginx -t
systemctl reload nginx
```
