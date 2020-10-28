#!/bin/bash

# Initial Tests
f5_bin=`which f5`
if [ ! -e ${f5_bin} ] || [ -z ${f5_bin} ]; then
  echo "f5-cli doesn't exist in the system."
  echo "Please install using # pip install f5-cli"
  echo "Exiting..."
  exit 1
fi

BIGIP_ROOT='root'
BIGIP_ROOT_PWD='default'

BIGIP_ADMIN='admin'
BIGIP_ADMIN_PWD='admin'

BIGIP_MGMT='10.1.1.245'

SSH_KEY='~/.ssh/id_rsa.pub'

DO_JSON='../DO/do-vlab-full.json'

AS3_JSON_DVWA='../AS3/as3-dvwa.json'
AS3_JSON_FWD='../AS3/as3-forwarding.json'