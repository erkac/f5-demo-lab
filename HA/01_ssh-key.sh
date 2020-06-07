#!/bin/bash

. ./00_environment.sh

for bigip in "${BIGIP_MGMTS[@]}" ; do
    echo "Copy SSH Pub Key to BIG-IP - $bigip..."
    ssh-copy-id -f -i ${SSH_KEY} ${BIGIP_ROOT}@${bigip}
done