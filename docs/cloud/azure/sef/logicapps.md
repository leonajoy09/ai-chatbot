# Azure Logic Apps

```
Microsoft.Logic/workflows
Microsoft.Logic/workflows/*
```

## Minimum required configuration

- Logic App Standard should be used over consumption
- The Logic App should have vNET integration
- The Logic App should have a private endpoint attached
- The Logic App should have HTTPS-only traffic configured
- The Logic App should have Minimum Inbound TLS Version set to 1.2
- The Logic App should use Managed Identity
- The Logic App should use only Azure AD RBAC (disable SCM, and FTP deployments)
- The Logic App should use a key vault for storing secrets, and certificates

## Enforced Policies

{{ display_azure_policies('logic') }}

## Terraform example

Coming soon
