# Azure Data Factory

```
Microsoft.DataFactory/*
```

## Minimum required configuration

- Public network access on Azure Data Factory should be disabled
- Integration runtime should be virtual network integrated (use the Azure integration runtime with a managed virtual network or self-hosted integration runtime)
- Linked services should be connected using Private Endpoints
- Linked services should use system-assigned managed identity authentication when it is supported
- Linked services should use Key Vault for storing secrets
- Use the Git repository integration to store Data Factory configuration in source control
- SQL Server Integration Services integration runtimes on Azure Data Factory should be joined to a virtual network
- Azure Data Factory integration runtimes should be vNet integrated

## Enforced Policies

{{ display_azure_policies('adf') }}

## Terraform example

Coming soon
