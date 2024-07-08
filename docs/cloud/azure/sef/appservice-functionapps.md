# Azure App Service and Function Apps

```
Microsoft.Web/certificates
Microsoft.Web/certificates/*
Microsoft.Web/connections
Microsoft.Web/connections/*
Microsoft.Web/serverfarms
Microsoft.Web/serverfarms/*
Microsoft.Web/sites
Microsoft.Web/sites/*
```

## Minimum required configuration

!!! success "Use Azure Key Vault to store secrets"

    Azure Key Vault is a secure and encrypted vault for storing secrets such as passwords, certificates, API keys, and other sensitive information. Secrets used with Azure App Services and Function Apps must be added as a [Key Vault reference](https://learn.microsoft.com/en-gb/azure/app-service/app-service-key-vault-references?tabs=azure-cli). Key Vaults enforce secure authentication through Entra ID, secret rotation without application redeployment and support monitoring of access and use.

- Require TLS 1.2
- Use only Azure AD RBAC (disable SCM, FTP deployments)
- HTTP to HTTPS redirect
- Use Managed Identity for authentication to other dependent services like Storage Account
- Use a tech stack which is still in support
- Use Key Vault for certificates and Key Vault References for secrets
- Inject into vNET to access private network resources
- App Services only used by Henkel employees, shall use a Private Endpoint
- Public-facing App Services should use an Azure Service with a Web Application Firewall in front like Application Gateway or Azure Front Door

## Enforced Policies

{{ display_azure_policies('appservice') }}

## Virtual Network Integration

- Inbound traffic to an App Service is through a Private Endpoint ([Using Private Endpoints for App Service apps](https://learn.microsoft.com/en-us/azure/app-service/overview-private-endpoint))
- The App Service must be injected into a Virtual Network for outbound traffic to the private network and the `vnetRouteAllEnabled` setting must be enabled ([Configure application routing](https://learn.microsoft.com/en-us/azure/app-service/configure-vnet-integration-routing#configure-application-routing))
- The minimum subnet size is `/28`, but Microsoft recommends using a `/26` ([Subnet requirements](https://learn.microsoft.com/en-us/azure/app-service/overview-vnet-integration#subnet-requirements))
- The subnet must be delegated `Microsoft.Web/serverFarms` ([Enable virtual network integration in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/configure-vnet-integration-enable#prerequisites))
- Function Apps using a virtual network integrated storage account requires inbound ports 443, and 445 open on the Storage Account inbound and likewise ports outbound on the subnet delegated to the Function App

## Terraform example

### App service example

``` terraform linenums="1"
--8<-- "templates/appservice.tf"
```

### Function App Example

``` terraform linenums="1"
--8<-- "templates/functionapp.tf"
```
