#!/bin/bash

. ./00_environment.sh

# F5-CLI
echo "Configure F5-CLI Defaults..."
f5 config set-defaults --disable-ssl-warnings true --auto-approve
echo "Login to BIG-IP..."
f5 login --authentication-provider bigip --host ${BIGIP_MGMT} --user ${BIGIP_ADMIN} --password ${BIGIP_ADMIN_PWD}

echo
echo "Install DO Extension..."
f5 bigip extension do install
f5 bigip extension do verify
sleep 10

echo
echo "Deploy DO JSON..."
# Patch the license in JSON
if [ -n "$1" ]; then
  echo "Patching license to ${DO_JSON}..."
  LICENSE="$1"
  cat ${DO_JSON} | sed "s/\"regKey\": \".*\",/\"regKey\": \"$LICENSE\",/g" > ${DO_JSON}.tmp
  f5 bigip extension do create --declaration ${DO_JSON}.tmp
  rm -f ${DO_JSON}.tmp
else
  f5 bigip extension do create --declaration ${DO_JSON}
fi

echo
echo "Verify the deployed configuration..."
f5 bigip extension do show
