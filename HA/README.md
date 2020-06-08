# F5 HA

Scripts to deploy F5 Demo Lab Using [F5-CLI](https://github.com/f5devcentral/f5-sdk-python) and Automation Toolchain - [DO](https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest), [AS3](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest).

For more details please refer to `../F5-CLI/README.md`.

This folders contains example for two BIG-IPs HA deployment. The only difference to `../F5-CLI/README.md` is to, that this example is using for cycle in order to connect and configure IPs deffined in `BIGIP_MGMTS` array in the `./00_environment.sh` configuration file.

## Notes

[DO Clustering](https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/clustering.html)