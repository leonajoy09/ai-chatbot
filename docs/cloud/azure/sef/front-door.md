# Azure Front Door

```
Microsoft.Cdn/profiles/*
```

## Minimum required configuration

- Use the Premium SKU. This is to enable support for Microsoft Managed WAF rules and private links
- Use Private links to connect to origins
- Minimum TLS version should be 1.2
- Use system-assigned managed identity to integrate with other services
- Use OWASP 3.2 as the default rule set for the WAF policy
- Deploy the WAF policy first in Detection mode while inspecting the impact of the WAF policy before setting it to Prevention mode which is the desired WAF mode
- Azure Web Application Firewall on Azure Front Door should have request body inspection enabled
- Azure Web Application Firewall should be enabled for Azure Front Door entry-points

## Enforced Policies

{{ display_azure_policies('afd') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/frontdoor.tf"
```