# Azure Recovery Services Vault

```
Microsoft.RecoveryServices/vaults
```

!!! tip "Recovery Services Vault is available as a Platform provided service"

    Recovery Services Vaults can be provisioned through the Landing Zone configuration files as a Platform service for the use case of backup of Virtual Machines and SQL Server on Azure VM. Read more about the Platform feature [Automated Backup of VMs and SQL Server VMs](../platform-guide/vm/backup.md).

## Minimum required configuration

- Disable Public Access entirely, use Private Endpoints
- Enable soft delete on the vault
- Disable cross-subscription restore feature
- Consider enabling Immutability on the vault for critical data applications
- Consider configuring Zone-Redundant Storage (ZRS) or Geo-Redundant Storage (GRS) for critical data applications

## Enforced Policies

{{ display_azure_policies('rsv') }}

## Terraform example

Coming soon
