# Azure Static Web Apps

```
Microsoft.Web/staticSites/*
```

## Minimum required configuration

- Use the Standard SKU as it supports Private Endpoints
- Configure a Static Web App with Private Endpoints. Be aware that using a Private Endpoint disables public access to the Static Web App
- If the Static Web App requires public exposure, a service that supports a Web Application Firewall (WAF) should be used in front, e.g. [Application Gateway](./application-gateway.md) or [Front Door](./front-door.md)
- Managed Functions (the built-in Managed Functions App feature in Static Web Apps) should not be used due to their lack of controls. Provision and bring your own Function in accordance with the requirements listed under [Function Apps](./appservice-functionapps.md)

## Enforced Policies

{{ display_azure_policies('staticwebapps') }}

## Terraform example

Coming soon