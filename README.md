# F5 Demo Lab

> F5 Automation Toolchain is supported in TMOS v13 or higher.

My sets of scripts to deploy **[F5 BIG-IP](https://www.f5.com)** instance in local VMware Fusion.

## AS3 Folder

Basic examples of F5 Automation Toolchain - AS3 to configure Application Services.
* `./AS3/as3-dvwa.json`
  * Damn Vulnerable Web Application Running in F5 LAMP Server
* `./AS3/as3-forwarding.json`
  * Generic L3 Forwarding VS Server
* `./AS3/as3-petstore-waf.json`
  * [Swagger Petstore](https://petstore.swagger.io/) with [Declarative WAF Policy](https://devcentral.f5.com/s/articles/Advanced-WAF-v16-0-Declarative-API)

## DO Folder

Experiments with Declarative On-Boarding.
* `./DO/install-do.sh`
  * custom script to install DO Extension, later was replaced with F5-CLI in this demo
* `./DO/do-vlab-full-example.json`
  * Full BIG-IP demo Provisioning
  * In order to work with `./F5-CLI/04_do.sh` it is need to
    * rename `./DO/do-vlab-full-example.json` to .`/DO/do-vlab-full.json`
    * insert valid Base Reg Key to `"regKey":` 

## TS Folder
Testing Telemetry streaming module for logging. It contains just Generic HTTP Consumer `./TS/ts-generic-http.json` which is getting data from example app `./TS/as3-example-app.json`.

## F5-CLI Folder

Contains several scripts to start the fully configured BIG-IP. Main work is done by [F5-CLI](https://github.com/f5devcentral/f5-cli). More details in [./F5-CLI/README.md](https://github.com/erkac/f5-demo-lab/blob/master/F5-CLI/README.md).

## HA Folder

My try to configure a cluster of two BIG-IPs using **F5-CLI** and **DO**. Work in progress...

## WAF Folder

Declarative WAF Policy in JSON format. `./WAF/start-web-server.sh` starts local WEB server which is able to serve `/awaf-declarative.json` policy when using AS3 declaration for *Petstore* example.

## TEST

Testing the deployed configuration using [Chef InSpec](https://docs.chef.io/inspec/).

## Components

### BIG-IP

**Networking**

* BIG-IP MGMT: *10.1.1.245*
  * MGMT GW: *10.1.1.2*
* Internal: *10.1.20.241*
    * Floating: *10.1.20.240*
* External: *10.1.10.241*
    * Floating: *10.1.10.240*
* Default GW: *10.1.10.2*

**Credentials**

* Login: *admin*
* Password: *admin*

### DVWA

> Not Part of this demo.

* LAMP IP: *10.1.20.17*
* Credentials: *hacker* / *hackyou*

### httpbin

> Not Part of this demo.

### XML Security GW

> Not Part of this demo.

Very Simple Web App, able to consume XML Inputs [docker-xml-server](https://github.com/erkac/docker-xml-server).

### JSON Security GW

> Not Part of this demo.

Very simple Web App, able to consume JSON Inputs [docker-json-server](https://github.com/erkac/docker-json-server).

## Other Notes


