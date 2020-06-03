# F5 CLI

[F5-CLI Homepage](https://github.com/f5devcentral/f5-sdk-python)

## F5-CLI instalation

```shell
$ pip install f5-cli
```

## BIG-IP Preparation

1. Console
  * Login as root, set the password
  * `# config` -> set the static IP and Default GW
  * `# tmsh modify sys global-settings mgmt-dhcp disabled` -> disable the dhcp on the mgmt interface
2. Change the admin password
  * via WebUI -> Login as admin, set the new password
  * or using tmsh -> `# tmsh modify auth user admin password <password>` and save the config `# tmsh save sys config`

## Shell Scripts

### ./00_environment.sh

* Setup the Environment using shell variables.

### ./01_ssh-key.sh

* Install the ssh public key to F5 Shell.
* The script will ask you for the root password.

### ./02_fix_chrome.sh

* Regenerate the certificate for F5 MGMT to resolve the issue in Chrome based browers (at least) on macOS. 
* `./openssl.cnf` contains the SSL certificate configuration.

### ./03_do.sh

* Install the latest version of DO extension to BIG-IP.
* Install the DO from `../DO/do-vlab-full.json`.
* Please do not forget to insert the valid Registration Key into `"regKey":` variable in `../DO/do-vlab-full.json`. 
* Sometimes (sometimes, when the instalation of DO takes a longer time) it returns an error, but please look for the final status of the command (or double check using `f5 bigip extension do show`):

```json
    "result": {
        "class": "Result",
        "code": 200,
        "message": "success",
        "status": "OK"
    },
```

### ./04_as3.sh

* Install the latest version of AS3 extension to BIG-IP.
* Install the example declarations from asd `../AS3/` folder.
* The same as in DO, please check for the result of AS3 declaration:

```json
    "results": [
        {
            "code": 200,
            "host": "localhost",
            "lineCount": 22,
            "message": "success",
            "runTime": 1012,
            "tenant": "Forward_tenant"
        }
```

## F5-CLI Notes

1. Disable the SSL Warnings

```console
$ f5 config set-defaults --disable-ssl-warnings true
```

2. Login to BIG-IP

```console
$ f5 login --authentication-provider bigip --host 10.1.1.245 --user admin
```

3. Delete Declaration Examples

```console
$ f5 bigip extension as3 delete --declaration ../AS3/as3-dvwa.json`
```

At the moment it deletes the whole configuration, even with exact specification, which declaration you want to delete. [F5-CLI Delete Declaration Bug](https://github.com/f5devcentral/f5-cli/issues/12)
