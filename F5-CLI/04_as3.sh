#!/bin/bash

. ./00_environment.sh

# F5-CLI
echo "Configure F5-CLI Defaults..."
f5 config set-defaults --disable-ssl-warnings true --auto-approve
echo "Login to BIG-IP..."
f5 login --authentication-provider bigip --host ${BIGIP_MGMT} --user ${BIGIP_ADMIN} --password ${BIGIP_ADMIN_PWD}

echo
echo "Install AS3 Extension..."
f5 bigip extension as3 install
f5 bigip extension as3 verify
sleep 5

echo
echo "Deploy AS3 JSONs..."
f5 bigip extension as3 create --declaration ${AS3_JSON_DVWA}
f5 bigip extension as3 create --declaration ${AS3_JSON_FWD}
echo
echo "Verify the deployed configuration..."
f5 bigip extension as3 show
