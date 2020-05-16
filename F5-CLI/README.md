# F5 CLI

[Homepage](https://github.com/f5devcentral/f5-sdk-python)

## Setup
    $ pip install f5-cli

## BIG-IP Preparation

1. Console -> Login as root, set the password

2. Console
    * set the static IP and Default GW
    * ddd

3. WebUI -> Login as admin, set the password

4. Create a openssl configuration file:

```console
# vi /config/openssl.cnf
```

5. Create new certificate/key for tmui:

```console
# openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout /config/httpd/conf/ssl.key/server.key -out /config/httpd/conf/ssl.crt/server.crt -config /config/openssl.cnf -extensions v3_req
```

6. Verify certificate:

```console
# openssl x509 -in /config/httpd/conf/ssl.crt/server.crt -noout -text
```
7. restart httpd
```console
# bigstart restart httpd
```

## Configuration

1. Disable the SSL Warnings

```console
$ f5 config set-defaults --disable-ssl-warnings true
```

2. Login to BIG-IP

```console
$ f5 login --authentication-provider bigip --host 10.1.1.245 --user admin
```

3. 
