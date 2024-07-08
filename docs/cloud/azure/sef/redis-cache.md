# Azure Cache for Redis

```
Microsoft.Cache/Redis/*
```

## Minimum required configuration

- Redis version 6.0 should be used
- Minimum TLS version should be set to 1.2
- Non-SSL ports should not be enabled
- The resource should preferably be vNET injected, at least have a private endpoint
- Public network access should be disabled
- Active directory authentication should be enabled
- System-assigned managed identity should be used for outbound connectivity to other services.
- `managedIdentity` should be set as the preferred data persistence authentication method if either AOF or RDB backup is enabled

## Virtual Network Integration

- Inbound traffic to a Cache for Redis is [through a Private Endpoint](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-private-link)
- Several in and outbound should be opened, follow [Azure Documentation](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-vnet#outbound-port-requirements)

## Enforced Policies

{{ display_azure_policies('redis') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/redis.tf"
```