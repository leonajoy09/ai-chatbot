# Azure Key Vault

```
Microsoft.KeyVault/*
```

## Minimum required configuration

- Use RBAC permission model
- Restrict Public Access completely, use Private Endpoint
- Purge protection should be enabled
- Soft delete should be enabled
- Enforce logging of Key vault operation activities

## Enforced Policies

{{ display_azure_policies('keyvault') }}


## Virtual Network Integration
- Inbound access through a Private Endpoint ([Integrate Key Vault with Azure Private Link](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-service))

## Terraform example

``` terraform linenums="1"
--8<-- "templates/keyvault.tf"
```