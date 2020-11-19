# F5 AS3

## Resources

### TechDoc
- [F5 Clouddocs](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/)

### Example Configurations
- [HTTP based Examples](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/3.5.1/refguide/additional-examples.html)
- [Non HTTP Services](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/declarations/non-http-services.html)
- [AS3 WAF Declarative](https://devcentral.f5.com/s/articles/Advanced-WAF-v16-0-Declarative-API)

### Download
- [github F5 Networks](https://github.com/F5Networks/f5-appsvcs-extension/releases)

## Notes
* For troubleshooting please look into `/var/log/restjavad.*.log` and `/var/log/restnoded/restnoded.log`

### Remove the declaration

`DELETE` to `https://{{bigip1}}/mgmt/shared/appsvcs/declare` removes the declaration in the body

### Add Node to a Pool

1. review the declaration or first use `GET https://<BIG-IP>/mgmt/shared/appsvcs/declare/{{tennant}}`
2. `PATCH https://<BIG-IP>/mgmt/shared/appsvcs/declare` with the following body

```json
[
  {
    "op": "add",
    "path": "/Sample_04/ApplicationA/web_pool/members/0/serverAddresses/-",
    "value": "192.0.1.172"
  }
]
```

### Parse the Auth token from the response
```shell
$ curl --location --request POST 'https://10.1.1.245/mgmt/shared/authn/login' --header 'Content-Type: application/json' --header 'Content-Type: text/plain' --data-raw '{
    "username":"admin",
    "password":"admin",
    "loginProviderName":"tmos"
}' | jq '.token | .token'
```
