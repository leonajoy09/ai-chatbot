# Azure App Configuration

```
Microsoft.AppConfiguration/configurationStores
```

## Minimum required configuration

!!! success "Use Azure Key Vault to store secrets"

    Azure Key Vault is a secure and encrypted vault for storing secrets such as passwords, certificates, API keys, and other sensitive information. Secrets used with Azure App Configuration must be added as a [Key Vault reference](https://learn.microsoft.com/en-us/azure/azure-app-configuration/use-key-vault-references-dotnet-core?tabs=core6x). Key Vaults enforce secure authentication through Entra ID, secret rotation without application redeployment and support monitoring of access and use.

- Use Standard SKU that supports Private Endpoints
- Use Private Endpoints
- Disable Public Access
- Disable the use of Access Keys

## Virtual Network Integration

- Inbound traffic to a Service Bus is [through a Private Endpoint](https://learn.microsoft.com/en-us/azure/azure-app-configuration/concept-private-endpoint)
- Port HTTPS (443) should be open

## Enforced Policies

{{ display_azure_policies('appconfiguration') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/appconfiguration.tf"
```