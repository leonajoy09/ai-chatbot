# Azure Backup Vault

```
Microsoft.DataProtection/backupVaults
```

!!! note "Vaulted backup (preview) is not supported"

    Due to concerns with Henkel Security policies, Azure Backup vault can only be used for Operational backups. The preview feature Vaulted backup must not be used.

## Minimum required configuration

- Enable system managed identity
- Enable soft delete with at least 14 days retention
- Enable built-in alerts for failed backups and restores
- Enable immutable vault and lock it
- Disable cross subscription restore

## Enforced Policies

{{ display_azure_policies('bvault') }}

## Terraform example

The below example uses the [AzApi Terraform Provider](https://registry.terraform.io/providers/Azure/azapi/latest/docs) due to limitations in configuration options with the AzureRM provider at the time of documentation writing.

``` terraform linenums="1"
--8<-- "templates/backupvault.tf"
```