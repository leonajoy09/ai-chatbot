# Azure Container Registry

```
Microsoft.ContainerRegistry/*
```

## Minimum required configuration

- Premium SKU should be used to support private endpoints
- Private endpoint should be enabled
- Disable public network access
- Disable anonymous authentication
- Disable local admin account
- Enabled Microsoft Defender for Containers
- Should have vulnerability findings in Defender Recommendations resolved
- Diagnostic setting with audit logs to Log Analytics Workspace should be configured

## Enforced Policies

{{ display_azure_policies('acr') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/container_registry.tf"
```
