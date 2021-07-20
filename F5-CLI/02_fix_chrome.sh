#!/bin/bash

. ./00_environment.sh

# Fix Chrome certificate issues on macOS
echo "Fix Chrome Certificate issues on macOS..."
scp ./openssl.cnf ${BIGIP_ROOT}@${BIGIP_MGMT}:/config/openssl.cnf
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout /config/httpd/conf/ssl.key/server.key -out /config/httpd/conf/ssl.crt/server.crt -config /config/openssl.cnf -extensions v3_req"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "openssl x509 -in /config/httpd/conf/ssl.crt/server.crt -noout -text"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "bigstart restart httpd"
