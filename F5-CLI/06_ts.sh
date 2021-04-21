#!/bin/bash

. ./00_environment.sh

# F5-CLI
echo "Configure F5-CLI Defaults..."
f5 config set-defaults --disable-ssl-warnings true --auto-approve
echo "Login to BIG-IP..."
f5 login --authentication-provider bigip --host ${BIGIP_MGMT} --user ${BIGIP_ADMIN} --password ${BIGIP_ADMIN_PWD}

echo
echo "Install TS Extension..."
f5 bigip extension ts install
f5 bigip extension ts verify
sleep 5

echo
echo "Deploy TS JSONs..."
f5 bigip extension ts create --declaration ${TS_HTTP_GENERIC}
echo "Deploy AS3/TS JSONs..."
5 bigip extension as3 create --declaration ${AS3_TS_APP}

echo
echo "Verify the deployed configuration..."
f5 bigip extension ts show
