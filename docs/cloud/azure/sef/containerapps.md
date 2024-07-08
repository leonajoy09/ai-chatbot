# Azure Container Apps

```
Microsoft.App/containerApps*
Microsoft.Web/kubeEnvironments*
```

## Minimum required configuration

- Use [Workload profile Environment Type](https://learn.microsoft.com/en-us/azure/container-apps/workload-profiles-overview) for Container Environments
- Disable public network access by deploying an [Internal-only container apps environment configuration](https://learn.microsoft.com/en-us/azure/container-apps/networking?tabs=workload-profiles-env%2Cazure-cli#accessibility-levels)
- Container App should configure with volume mount for persistence (when required by the application)
- If a Container App is an internal end-user application, an identity provider is required
- Public-facing Container Apps should use an Azure Service with a Web Application Firewall in front like Application Gateway or Azure Front Door

!!! success "Use Azure Key Vault to store secrets"

    Azure Key Vault is a secure and encrypted vault for storing secrets such as passwords, certificates, API keys, and other sensitive information. Secrets used with Azure Container Apps must be added as a [Key Vault reference](https://learn.microsoft.com/en-us/azure/container-apps/manage-secrets?tabs=azure-portal#reference-secret-from-key-vault). Key Vaults enforce secure authentication through Entra ID, secret rotation without application redeployment and support monitoring of access and use.

## Enforced Policies

{{ display_azure_policies('containerapps') }}

## Virtual Network Integration

- Container Apps deployed in a virtual network (vNET), require certain in- and outbound NSGs rules allowed - see further in [Microsoft Learn documentation](https://learn.microsoft.com/en-us/azure/container-apps/firewall-integration?tabs=workload-profiles)

## Terraform example

``` terraform linenums="1"
--8<-- "templates/containerapps.tf"
```
