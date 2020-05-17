#!/bin/bash

. ./00_environment.sh

echo "Copy SSH Pub Key to BIG-IP..."
ssh-copy-id -i ${SSH_KEY} ${BIGIP_ROOT}@${BIGIP_MGMT}
