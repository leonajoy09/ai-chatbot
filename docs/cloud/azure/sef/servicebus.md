# Azure Service Bus

```
Microsoft.ServiceBus/namespaces
Microsoft.ServiceBus/namespaces/*
```

## Minimum required configuration

- Use Premium SKU that supports Private Endpoints
- Disable Public Access
- Enforce minimum TLS version 1.2
- Disable Local Authentication/Shared Access Policies

## Virtual Network Integration

- Inbound traffic to a Service Bus is [through a Private Endpoint](https://learn.microsoft.com/en-us/azure/service-bus-messaging/private-link-service)
- Ports AMQP (5671) and HTTPS (443) should be open

## Enforced Policies

{{ display_azure_policies('servicebus') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/servicebus.tf"
```