#!/bin/bash

. ./00_environment.sh

# Fix Chrome certificate issues on macOS
for bigip in "${BIGIP_MGMTS[@]}" ; do
  echo "Fix Chrome Certificate issues on macOS - BIG-IP - ${bigip}..."
  scp ./openssl.cnf ${BIGIP_ROOT}@${bigip}:/config/openssl.cnf
  ssh ${BIGIP_ROOT}@${bigip} "openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout /config/httpd/conf/ssl.key/server.key -out /config/httpd/conf/ssl.crt/server.crt -config /config/openssl.cnf -extensions v3_req"
  ssh ${BIGIP_ROOT}@${bigip} "openssl x509 -in /config/httpd/conf/ssl.crt/server.crt -noout -text"
  ssh ${BIGIP_ROOT}@${bigip} "bigstart restart httpd"
done