****************************************************************************************************************

** 注：配置过程比较复杂是因为curl参数--cacert --cert要求证书为pem格式，与keytool生成的der格式不符，需要使用openssl做一些转换。若客户端使用java程序，则配置过程相对简单。**

** 配置方法不唯一，双端验证也可以通过转换der格式到pem的方式配置 **

参考：

[curl命令](https://curl.haxx.se/docs/manpage.html)

[openssl命令](https://www.openssl.org/docs/manmaster/apps/openssl.html)

[springboot参数配置](http://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html)

****************************************************************************************************************

# ssl认证配置：

## 客户端验证服务器(单向认证):

### 1.keytool生成服务器密钥库server.keystore

keytool -genkey -alias server -keyalg RSA -validity 365 -keystore server.keystore

### 2.keytool导出服务器证书 serverCA.crt

keytool -export -alias server -keystore server.keystore -file serverCA.crt

### 3.openssl将服务器证书由der转换为pem格式

openssl x509 -inform DER -in serverCA.crt  -out serverCA.pem -text

### 4.服务器配置文件application.properties配置：

server.ssl.key-store=server.keystore

server.ssl.key-store-password=123456

server.ssl.keyStoreType=JKS

server.ssl.keyAlias:server

将1中生成的server.keystore放入interfaceService.jar同级目录

启动服务器

### 5.客户端使用curl访问服务器

curl -i "https://localhost:8899/web/rest/user/users/login?userName=sysdba&password=szoscar55" --cacert serverCA.pem

其中，serverCA.pem指向3中生成的serverCA.pem

## 服务器验证客户端(双向认证)：

### 1.openssl生成客户端证书

#### (1).openssl生成CA根证书

生成私钥：

openssl genrsa -des3 -out ca.key 2048

生成证书请求：

openssl req -new -key ca.key -out ca.csr

生成根证书

openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt  

#### (2).openssl生成客户端证书

生成私钥

openssl genrsa -des3 -out client.key 1024 

生成证书请求

openssl req -new -key client.key -out client.csr

生成客户端证书

openssl ca -in client.csr -out client.crt -cert ca.crt -keyfile ca.key  

### 2.生成客户端密钥库

linux: cat client.crt client.key>client.pem

windows: type client.crt client.key>client.pem

### 3.生服务器信任库(注：单向验证中客户端没有生成信任库是因curl参数 --cacert指定信任证书)

####(1).openssl将客户端证书由pem转换为der格式

openssl x509 -in client.crt -outform der -out client.der

####(2).keystool将客户端证书导入信任库(如有多个信任客户端，可重复导入truststore.jks)

keytool -keystore truststore.jks -alias client -import -trustcacerts -file client.der

### 4.服务器配置文件application.properties的配置

\#Whether client authentication is wanted ("want") or needed ("need"). Requires a trust store.

server.ssl.client-auth=need

server.ssl.trust-store=truststore.jks 

server.ssl.trust-store-password=123456

将3中生成的truststore.jks放入interfaceService.jar同级目录

启动服务器

###5.客户端使用curl访问服务器

curl -i "https://localhost:8899/web/rest/user/users/login?userName=sysdba&password=szoscar55" --cert client.pem --cacert serverCA.pem

其中，client.pem 指向2生成的client.pem 


