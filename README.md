# F5 Demo Lab

My sets of scripts to deploy F5 BIG-IP instance in local VMware Fusion.

## AS3 Folder

Basic examples of F5 Automation Toolchain - AS3 to configure Application Services.

* ./AS3/as3-dvwa.json
  * Damn Vulnerable Web Application Running in F5 LAMP Server
* ./AS3/as3-forwarding.json
  * Generic L3 Forwarding VS Server

## DO Folder

Experiments with Declarative On-Boarding.
* ./DO/install-do.sh
  * custom script to install DO Extension, later was replaced with F5-CLI in this demo
* ./DO/do-vlab-full-example.json
  * Full BIG-IP demo Provisioning
  * In order to work with ./F5-CLI/03_do.sh it is need to
    * rename ./DO/do-vlab-full-example.json to ./DO/do-vlab-full.json
    * insert valid Base Reg Key in "regKey": 

## F5-CLI Folder

Contains serveral scripts to start the fully running demo.

## Components

### BIG-IP

**Networking**

* BIG-IP MGMT: 10.1.1.245
* Internal: 10.1.20.241
    * Floating: 10.1.20.240
* External: 10.1.10.241
    * Floating: 10.1.10.240

**Credentials**

* Login: admin
* Password: admin

### DVWA

* LAMP: 10.1.20.17
* Credentials: hacker / hackyou

### httpbin

### XML Security GW

### JSON Security GW

* demo33@fidnet.com / mountainman01

