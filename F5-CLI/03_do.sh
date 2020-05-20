#!/bin/bash

. ./00_environment.sh

# F5-CLI
echo "Configure F5-CLI Defaults..."
f5 config set-defaults --disable-ssl-warnings true --auto-approve
echo "Login to BIG-IP..."
f5 login --authentication-provider bigip --host ${BIGIP_MGMT} --user ${BIGIP_ADMIN} --password ${BIGIP_ADMIN_PWD}

echo "Install DO Extension..."
f5 bigip extension do install
f5 bigip extension do verify

echo "Deploy DO JSON..."
f5 bigip extension do create --declaration ../DO/do-vlab-full.json
echo "Verify the deployed configuration..."
f5 bigip extension do show
