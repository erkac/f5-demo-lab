#!/bin/bash

DEBUG="n"

if [ $DEBUG -eq "y" ]; then
    CURL_PARAM="-v"
else
    CURL_PARAM="-s"
fi

FN=f5-declarative-onboarding-1.11.1-1.noarch.rpm
LEN=$(wc -c $FN | cut -f 2 -d ' ')

# Credentials
CREDS=admin:admin
IP=10.1.1.245

# Update the admin password
#curl $CURL_PARAM -ku $CREDS https://$IP/mgmt/shared/authz/users/admin -H "Content-Type: application/json" -X PATCH -d '{"oldPassword":"admin","password":"admin"}'

# Upload the DO RPM
curl $CURL_PARAM -ku $CREDS https://$IP/mgmt/shared/file-transfer/uploads/$FN -H 'Content-Type: application/octet-stream' -H "Content-Range: 0-$((LEN - 1))/$LEN" -H "Content-Length: $LEN" -H 'Connection: keep-alive' --data-binary @$FN

# Install the DO RPM
DATA="{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/$FN\"}"
curl $CURL_PARAM -ku $CREDS "https://$IP/mgmt/shared/iapp/package-management-tasks" -H "Origin: https://$IP" -H 'Content-Type: application/json;charset=UTF-8' --data $DATA

# Check the DO RPM Instalation status
curl $CURL_PARAM -ku $CREDS https://$IP/mgmt/shared/declarative-onboarding/info | jq

# Instal the DO Configuration
DO_JSON=do-vlab-full.json
curl $CURL_PARAM -ku $CREDS https://$IP/mgmt/shared/declarative-onboarding -H "Content-Type: application/json" -X POST --data @$DO_JSON | jq

# Check the processing of DO
curl $CURL_PARAM -ku $CREDS https://$IP/mgmt/shared/declarative-onboarding -X GET | jq