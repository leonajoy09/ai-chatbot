# Automated Backup of VMs and SQL Server VMs

!!! note
The automation for backups of databases on SQL server on Virtual Machines uses the computer name of the Virtual Machine for registration into the Recovery Services Vault. Changing the computer name after the backup have been registered might break the backup functionality for databases.

## Introduction

The Azure Henkel Platform supports the registration of _Virtual Machines_ and _SQL Server on Azure Virtual Machines_ in Azure Backup, along with the establishment of default backup policies.

This feature is available on an **opt-in** basis on a Virtual Network scope.

## How to enable Automated Backup

The Automated Backup feature is enabled inside the network configuration file (`network.<env>.json`) by providing a name of a subnet under the `azure_backup` property. A Private Endpoint will be deployed into the subnet. **Note:** There should be at least 10 available IP addresses in the subnet meaning that a `/27` subnet or larger is required.

It is recommended to use an immutable backup vault, as it ensures the backed up entites are preserved for the full retention period. By default the backup vault is set to be immutable, but it is possible to opt-out of the immutability by setting the immutability option to false. Once the backup vault is set to be immutable, it cannot be changed back to be immutable. It is also only possible to remove an immutable backup vault once all it's backed up entities have expired their retention period.

Here's an example of a configuration:

```json
{
  "vnets": [
    {
      "location": "westeurope",
      "azure_backup": {
        "subnet": "name-of-subnet",
        "immutability": true
      },
      "subnets": {
        "name-of-subnet": {
          "ip_range": "10.x.x.x/27"
        }
      }
    }
  ]
}
```

If a subscription contains multiple VNets, then the `azure_backup` property must be set on all the VNets where VMs should be enrolled into Automated Backup.

## Registration of new resources in Azure Backup?

New _Virtual Machines_ and _SQL Server on Virtual Machines_ should be registered with Azure Backup within 60 minutes after provisioning.

## Check registration of Virtual Machines

1. Open the Recovery Services Vault
2. Select _Backup items_ in the menu
3. Select the _Azure Virtual Machine_ backup management type
4. Verify that the expected Virtual Machines are included in the list

## Check registration of databases on SQL Server on Virtual Machine

1. Open the Recovery Services Vault
2. Select _Backup items_ in the menu
3. Select the _SQL in Azure VM_ backup management type
4. Verify that the expected databases are included in the list

## Deployed Resources

A number of resources are deployed into the network resource group (e.g., `dx-weu-dev-<lzName>net-rg`) when Azure Backup is enabled:

1. A Recovery Services Vault with a name like `dx-weu-dev-<lzName>net-rsv`
2. A Private Endpoint with a name like `dx-weu-dev-<lzName>net-pep-azurebackup`

In addition, Azure Backup will create one or more resource groups for storing restore points having names like `AzureBackupRG_westeurope_1`.

For _SQL Server on Virtual Machines_, Azure Backup installs the `AzureBackupWindowsWorkload` extension on the VM.

## Supported MS SQL settings

An overview of the supported SQL Server settings can be found [here](https://learn.microsoft.com/en-us/azure/backup/sql-support-matrix).

## Default Backup Policies

The following Backup Policies will be used for backup up Virtual Machines and SQL Databases:

### Virtual Machines

- A backup will be made every 4 hours between 8 AM and 8 PM UTC.
- A daily backup point will be stored for 30 days.

### SQL Databases

- A full backup will be made daily at 1 AM UTC and retained for 30 days.
- Database logs will be backed up every hour and retained for 30 days.

## Custom Backup Policies

Custom Policies are not currently supported through the Landing Zone configuration and App Teams should setup their own Recovery Services Vault.
