# Cosmos DB

```
Microsoft.DocumentDB/databaseAccounts
Microsoft.DocumentDB/databaseAccounts/*
    - Microsoft.DocumentDB/databaseAccounts/account1/gremlinDatabases
    - Microsoft.DocumentDB/databaseAccounts/account1/mongodbDatabases
    - Microsoft.DocumentDB/databaseAccounts/account1/sqlDatabases
    - Microsoft.DocumentDB/databaseAccounts/account1/tables
Microsoft.DocumentDB/cassandraClusters
Microsoft.DocumentDB/cassandraClusters/*
Microsoft.DBforPostgreSQL/serverGroupsv2
Microsoft.DBforPostgreSQL/serverGroupsv2/*
```

## Minimum required configuration

- Require TLS 1.2
- Enforce HTTPS
- Restrict public access
- Default deny action on the Cosmos DB Firewall
- For NoSQL API use Azure AD authentication for both data and management operations

## Enforced Policies

{{ display_azure_policies('cosmos') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/cosmosdb.tf"
```