# Azure Database for PostgreSQL - Flexible Server

```
Microsoft.DBforPostgreSQL/flexibleServers/*
```

## Minimum required configuration

- PostgresSQL server must be integrated with a virtual network and use a [Private DNS Zone](../platform-guide/azure-network-dns.md#custom-private-dns-zones)
- Public access should be disabled
- Require minimum TLS 1.2
- An Azure AD group must be set as Server Admin and authentication restricted to use Azure AD authentication only
- Minimum version N-1. Currently version 14

## Enforced Policies

{{ display_azure_policies('postgresql') }}

## Notes

- Be aware that the subnet delegated to the PostgreSQL server should have a service delegation with `Microsoft.DBforPostgreSQL/flexibleServers` and the action(s) `Microsoft.Network/virtualNetworks/subnets/join/action`. This can be configured in the landing zone configuration

## Terraform example

``` terraform linenums="1"
--8<-- "templates/postgresql.tf"
```