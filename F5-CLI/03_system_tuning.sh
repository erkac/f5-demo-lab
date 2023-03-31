#!/bin/bash

. ./00_environment.sh

echo "Tuning BIG-IP System for Automation Toolchain deployment..."
#echo "MGMT DHCP Disabled"
#ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify sys global-settings mgmt-dhcp disabled"
echo "Set Admin Password"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify auth user admin password ${BIGIP_ADMIN_PWD}"
echo "Set DNS Server to 1.1.1.1"
echo "Tune Management Plane Performance"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify /sys dns name-servers add { 1.1.1.1 }"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify sys db provision.extramb value 1024"
# https://my.f5.com/manage/s/article/K000092380
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify sys db restjavad.useextramb value true"
echo "Save Configuration..."
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh save sys config"
echo "Tune Timeouts..."
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify sys db icrd.timeout value 180"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify sys db restjavad.timeout value 180"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify sys db restnoded.timeout value 180"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh modify sys db icrd.timeout value 180"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh save sys config"
echo "Restart Services..."
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh restart sys service restjavad"
ssh -q ${BIGIP_ROOT}@${BIGIP_MGMT} "tmsh restart sys service restnoded"
