# Azure Application Gateway and WAF Policy

```text
Microsoft.Network/ApplicationGateways/*
Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/*
```

## Minimum required configuration

- Use HTTPS for all listeners
- Use TLS 1.2
- Use a separate Key Vault for storing certificates
- Use WAF V2 SKU
- Use WAF policy on all listeners with a public IP
- Deploy the WAF policy first in Detection mode while inspecting the impact of the WAF policy before setting it to Prevention mode which is the desired WAF mode
- Use OWASP 3.2 as the default rule set for the WAF policy

## Enforced Policies

{{ display_azure_policies('appgtw') }}

## Virtual Network Integration

- Application Gateway must be injected into a subnet without delegation that can't contain other resources ([Virtual network and dedicated subnet](https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure#virtual-network-and-dedicated-subnet))
- The minimum subnet size is `/26`, but Microsoft recommends a `/24` ([Size of subnet](https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure#size-of-the-subnet))
- NSG's must contain specific rules ([Network security groups](https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure#network-security-groups))

## Terraform example

``` terraform linenums="1"
--8<-- "templates/application-gateway.tf"
```

## Landing Zone example
```
--8<-- "templates/application-gateway-lz.json"
```

!!! note "Using SSL/TLS Offloading with Application Gateway"

    Currently, Application Gateways have an bug where Azure DNS is used for specfic domains (including Azure Key Vault). The landing zones do not use Azure DNS but Henkel DNS which will cause the Application Gateway to attempt connecting to public ip address instead of the private ip address for the specific domains.

    When using SSL/TLS Offloading the suggested workaround is to use Service Endpoints when obtaining certificates in [Azure Key Vault](https://learn.microsoft.com/en-us/azure/application-gateway/key-vault-certs).