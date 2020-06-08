# F5 DO

## Steps
1. Console
  * Login as root, set the password
  * `# config` -> set the static IP and Default GW
2. Change the admin password
  * via WebUI -> Login as admin, set the new password
  * or using tmsh -> `# tmsh modify auth user admin password <password>` and save the config `# tmsh save sys config`
4. Insert the valid Registration Key into `"regKey":` variable in `do-vlab-full.json`
5. Install the DO using one of the following ways:
  * Postman - use the [F5 Automation Toolchain Collection](https://raw.githubusercontent.com/jmcalalang/f5-automation-toolchain-lab/master/files/postman_collections/F5%20Automation%20Toolchain-%20Class.postman_collection.json)
  * `./install-do.sh`
  * using the `../F5-CLI/03_do.sh` script

## Notes
* For troubleshooting please look into `/var/log/restjavad.*.log` and `/var/log/restnoded/restnoded.log`

### DO RPM File
[Download](https://github.com/F5Networks/f5-declarative-onboarding/releases)

### Lab
[Automation Toolchain Lab](https://f5-automation-toolchain-lab.readthedocs.io/en/latest/docs/labinfo/labinfo2.html)

### TechDoc
[Clouddocs](https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/installation.html)
