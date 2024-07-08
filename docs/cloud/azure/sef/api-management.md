# Azure API Management

```
Microsoft.ApiManagement/service/*
```

## Minimum required configuration

- Use a service [SKU](https://learn.microsoft.com/en-us/azure/api-management/api-management-features) that allows for __internal__ virtual network integration (i.e. private inbound and outbound traffic). See further at [Deploy your Azure API Management instance to a virtual network - internal mode](https://learn.microsoft.com/en-us/azure/api-management/api-management-using-with-internal-vnet)
- Public network access must be switched off 
- The API Management must be exposed to the public internet with a service having a Web Application Firewall only. See example architecture here [Expose the developer portal and management endpoint externally through Application Gateway](https://learn.microsoft.com/en-us/azure/api-management/api-management-howto-integrate-internal-vnet-appgateway#expose-the-developer-portal-and-management-endpoint-externally-through-application-gateway)
- Use encrypted protocols for inbound and outbound traffic
- All API endpoints exposed in API Management must required authentication
- Calls from API Management to backends must be authenticated
- Access to direct management endpoints must be switched off
- Entra ID must be used for managing access to the Developer Portal
- Azure Key vault must be used to store certificates and secrets

## Enforced policies

{{ display_azure_policies('apimgmt') }}

## Virtual Network Integration

- API Management can be injected into a subnet without subnet delegation ([Network resource requirements for injection](https://learn.microsoft.com/en-us/azure/api-management/virtual-network-concepts#network-resource-requirements-for-injection))
- Minimum subnet size is `/29` ([Subnet size documentation](https://learn.microsoft.com/en-us/azure/api-management/virtual-network-concepts#subnet-size))
- A Private DNS Zone for DNS resolution ([Custom Private DNS Zones](../platform-guide/azure-network-dns.md))

## Terraform example

Coming soon