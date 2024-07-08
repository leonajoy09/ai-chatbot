# Azure Event Hub

```
Microsoft.EventHub/Namespaces/*
```

## Minimum required configuration

- Use RBAC permission model, so disable local authentication
- Disable Public Network Access
- Use Private Endpoint
- Minimum TLS version should be "1.2"
- Use system assigned managed identity to integrate with other services

## Enforced Policies

{{ display_azure_policies('eventhub') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/eventhub.tf"
```