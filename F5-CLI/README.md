# F5 CLI

[F5-CLI Homepage](https://github.com/f5devcentral/f5-sdk-python)

## F5-CLI installation

```shell
$ pip install f5-cli
$ f5 --help
```

I've found out that `f5-cli` is sensitive to `python` version.

## Makefile
Recently I added the `Makefile` to this repository. So instead of manually following all the procedures in the chapter below, you can now just run:
```bash
make LICENSE=<your_registration_key>
```
This will do the following:
1. Install SSH keys to BIG-IP
2. Fix issues with Config Utility in Chrome on Mac
3. Configure system parameters to run DO smoothly:
  - Disable DHCP on MGMT interface,
  - Set Admin Password,
  - set DNS Server to 1.1.1.1
  - Increase resources for MGMT Plane
4. Onboard BIG-IP
5. Deploy Application Services

The only pre-requisite for `make LICENSE=<your_registration_key>` is to login to *BIG-IP console* (thus set the *root*/*admin* password) and run the `config` command to set static IP address.

**Don't forget to run `start-web-server.sh` in `WAF` folder in order to let AWAF to download the Security policy.**

> For more information for each particular step and pre-requisites please read the chapter below.

## BIG-IP Preparation

1. Console
  * Login as root, set the password

  * type `config` to set the *static IP* and *default GW*

  * disable the DHCP on the MGMT interface

    ```shell
    tmsh modify sys global-settings mgmt-dhcp disabled
    tmsh save sys config
    ```

2. Change the admin password
  * via **WebUI** -> Login as admin, set the new password

  * or using **tmsh**

    ```shell
    tmsh modify auth user admin password <password>
    tmsh save sys config
    ```

3. Configure DNS
  * although the DNS configuration is part of DO JSON, it has failed for me too many times, mainly because if fails to activate the license

    ```shell
    tmsh modify /sys dns name-servers add { 1.1.1.1 }
    tmsh save sys config
    ```

4. Tune the **mgmt** - `restjavad` memory increase ([K00505373](https://support.f5.com/csp/article/K00505373))

    ```bash
    tmsh modify sys db provision.extramb value 1000
    tmsh modify sys db restjavad.useextramb value true
    tmsh save sys config
    ```

## Shell Scripts

> Before running these scripts, especially the `./04_do.sh`, please make sure, that the internet connectivity is working from BIG-IP eq. you are able to `ping activate.f5.com`.

### ./00_environment.sh

* Setup the Environment using shell variables.
* Included in all the scripts 01_... no need to execute separately.

### ./01_ssh-key.sh

  * Install the ssh public key to F5 Shell.
  * The script will ask you for the root password.
  * the ssh keys can be also installed using DO:
    ```json
    "root": {
        "class": "User",
        "userType": "root",
        "oldPassword": "default",
        "newPassword": "myNewPass1word",
        "keys": [
            "ssh-rsa <SSHKEY> <NAME>",
            "ssh-rsa <SSHKEY> <NAME>"
        ]
    },
    ```

### ./02_fix_chrome.sh

  * Regenerate the certificate for F5 MGMT to resolve the issue in Chrome based browsers (at least) on macOS. 
  * `./openssl.cnf` contains the SSL certificate configuration.

### ./03_system_tuning.sh

  * Does all of steps mentioned in pre-requisites, except setting the root's password.

### ./04_do.sh

  * Install the latest version of DO extension to BIG-IP.
  * Install the DO from `../DO/do-vlab-full.json`.
  * Please do not forget to insert the valid Registration Key into `"regKey":` variable in `../DO/do-vlab-full.json`. 
  * Sometimes (when the installation of DO takes a longer time) it returns an error, but please look for the final status of the command (or double check using `f5 bigip extension do show`):

    ```json
    "result": {
        "class": "Result",
        "code": 200,
        "message": "success",
        "status": "OK"
    },
    ```

  * Monitoring what is going on, and also for troubleshooting `tail -f /var/log/restnoded/restnoded.log`

### ./05_as3.sh

  * Install the latest version of AS3 extension to BIG-IP.
  * Install the example declarations from the `../AS3/` folder.
  * The same as in DO, please check for the result of AS3 declaration.
  * Uncomment `${AS3_JSON_PETSTORE}` in order to play with WAF declaration in AS3, for this kind of declaration you need to run at least _v16.0_ version of TMOS to be able to pull the swagger file specified in the WAF Policy `../AS3/awaf-declarative.json`

## F5-CLI Notes

1. Disable the SSL Warnings

    ```console
    f5 config set-defaults --disable-ssl-warnings true
    ```

2. Login to BIG-IP

    ```console
    f5 login --authentication-provider bigip --host 10.1.1.245 --user admin
    ```

3. Delete Declaration Examples

    ```console
    f5 bigip extension as3 delete --declaration ../AS3/as3-dvwa.json`
    ```

    At the moment it deletes the whole configuration, even with exact specification, which declaration you want to delete. [F5-CLI Delete Declaration Bug](https://github.com/f5devcentral/f5-cli/issues/12)

4. Troubleshooting

    ```shell
    tail -f /var/log/restnoded/restnoded.log
    ```