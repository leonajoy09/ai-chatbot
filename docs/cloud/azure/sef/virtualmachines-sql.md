# SQL Server on Azure VM

```
Microsoft.SqlVirtualMachine/*
```

!!! tip "Consider using Azure SQL database"

    Consider using the PaaS service [Azure SQL database](https://learn.microsoft.com/en-gb/azure/azure-sql/database/?view=azuresql) for new application development as it comes with built-in PaaS features for backup, monitoring and operations. SQL Server on Azure VM is more fitting for Lift and shift migrations or when full SQL server and OS controls are required.

## Minimum required configuration

!!! note

    Be aware that SQL Server on Azure VM is based on Azure Virtual Machines, the minimum requirements and enforced policies for Virtual Machines apply. Read more on Service Enablement documentation for [Azure Virtual Machines](./virtualmachines.md).

- Use a SQL version no older than SQL Server 2019
- When creating an SQL Server on Azure VM, set the SQL Connectivity option to `Private`
- Microsoft Entra authentication for SQL Server on Azure VMs (available from SQL Server 2022)
- To access the SQL databases port 1433 must be opened
  
## Enforced Policies

{{ display_azure_policies('sqlvm') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/sql-virtual-machine.tf"
```
