#!/bin/bash

. ./00_environment.sh

# F5-CLI
for bigip in "${BIGIP_MGMTS[@]}" ; do
  echo "BIG-IP - ${bigip}..."
  echo "Configure F5-CLI Defaults..."
  f5 config set-defaults --disable-ssl-warnings true --auto-approve
  echo "Login to BIG-IP..."
  f5 config auth create --authentication-provider bigip --name ${bigip} --host ${bigip} --user ${BIGIP_ADMIN} --password ${BIGIP_ADMIN_PWD}
  f5 login --authentication-provider bigip --host ${bigip} --user ${BIGIP_ADMIN} --password ${BIGIP_ADMIN_PWD}

  echo
  echo "Install DO Extension..."
  f5 bigip extension do install
  f5 bigip extension do verify
  sleep 10

  echo
  echo "Deploy DO JSON..."
  f5 bigip extension do create --declaration ${DO_JSON}-${bigip}.json
  echo
  echo "Verify the deployed configuration..."
  f5 bigip extension do show
  echo "=============================================================="
  echo
done