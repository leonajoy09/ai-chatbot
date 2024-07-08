# Azure Maps

```
Microsoft.Maps/accounts
```

## Minimum required configuration

- Use only EntraID-based authentication. Disable Local Authentication methods by [configuring the property `disableLocalAuth` to `true`](https://learn.microsoft.com/en-us/azure/azure-maps/azure-maps-authentication#disable-local-authentication)
- Do not configure CORS to allow all origins

## Enforced Policies

{{ display_azure_policies('maps') }}

## Terraform example

Coming soon
