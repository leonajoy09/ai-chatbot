# Azure SQL

```
Microsoft.Sql/*
```

## Minimum required configuration

- Set an Azure AD administrator
- Enable Defender for SQL
- Data Encryption
- Disable Public Access, Use private endpoints

## Enforced Policies

{{ display_azure_policies('sql') }}

## Virtual Network Integration
- Inbound access through a Private Endpoint ([Azure Private Link for Azure SQL Database and Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/azure-sql/database/private-endpoint-overview))

## Terraform example

``` terraform linenums="1"
--8<-- "templates/sql.tf"
```