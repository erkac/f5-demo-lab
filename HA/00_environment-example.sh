#!/bin/bash

BIGIP_ROOT='root'
BIGIP_ROOT_PWD='default'

BIGIP_ADMIN='admin'
BIGIP_ADMIN_PWD='admin'

BIGIP_MGMTS=( 10.1.1.245 10.1.1.246 )

SSH_KEY='~/.ssh/id_rsa.pub'

DO_JSON_BIGIP_A='./do-vlab-bigipA.json'
DO_JSON_BIGIP_B='./do-vlab-bigipB.json'

AS3_JSON_DVWA='../AS3/as3-dvwa.json'
AS3_JSON_FWD='../AS3/as3-forwarding.json'