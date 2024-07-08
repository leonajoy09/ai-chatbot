# Azure Database for MySQL - Flexible Server

```
Microsoft.DBforMySQL/flexibleServers*
```

## Minimum required configuration

- MySQL server should be provisioned in `Private Access` mode and must be integrated with a virtual network and use a [Platform provisioned Private DNS Zone](../platform-guide/azure-network-dns.md#custom-private-dns-zones)
- Public access should be disabled
- Require minimum TLS 1.2
- An Azure Entra ID group must be set as Server Admin and authentication restricted to use Entra ID authentication only
- Use minimum MySQL version 8 or higher
- Enforce only Entra ID

## Enforced Policies

{{ display_azure_policies('dbformysql') }}

## Notes

- Be aware that the subnet delegated to the MySQL Flexible server should have a service delegation with `Microsoft.DBforMySQL/flexibleServers` and the action(s) `Microsoft.Network/virtualNetworks/subnets/join/action`. This can be configured in the landing zone configuration

## Terraform example

``` terraform linenums="1"
--8<-- "templates/mysql-flexible.tf"
```
