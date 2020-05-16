#!/bin/bash

. ./00_environment.sh

echo "Copy SSH Pub Key to BIG-IP..."
ssh-copy-id -i ${SSH_KEY} ${BIGIP_ROOT}@${BIGIP_MGMT}


# Fix Chrome certificate issues on macOS
echo "Fix Chrome Certificate issues on macOS..."
scp ./openssl.cnf ${BIGIP_ROOT}@${BIGIP_MGMT}:/config/openssl.cnf
ssh ${BIGIP_ROOT}@${BIGIP_MGMT} "openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout /config/httpd/conf/ssl.key/server.key -out /config/httpd/conf/ssl.crt/server.crt -config /config/openssl.cnf -extensions v3_req"
ssh ${BIGIP_ROOT}@${BIGIP_MGMT} "openssl x509 -in /config/httpd/conf/ssl.crt/server.crt -noout -text"
ssh ${BIGIP_ROOT}@${BIGIP_MGMT} "bigstart restart httpd"

# F5-CLI
echo "Configure F5-CLI Defaults..."
f5 config set-defaults --disable-ssl-warnings true --auto-approve
echo "Login to BIG-IP..."
f5 login --authentication-provider bigip --host ${BIGIP_MGMT} --user ${BIGIP_ADMIN} --password ${BIGIP_ADMIN_PWD}

echo "Install DO Extension..."
f5 bigip extension do install
f5 bigip extension do verify

echo "Deploy DO JSON..."
f5 bigip extension do create --declaration ./DO/do-vlab.json
echo "Verify the deployed configuration..."
f5 bigip extension do show

echo "Install AS3 Extension..."
f5 bigip extension as3 install
f5 bigip extension as3 verify
f5 bigip extension as3 create --declaration ./AS3/as3-dvwa.json
f5 bigip extension as3 create --declaration ./AS3/as3-forwarding.json
f5 bigip extension as3 show