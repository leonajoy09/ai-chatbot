# Azure Databricks

```
Microsoft.Databricks/workspaces
```

## Minimum required configuration

- Dedicated Databricks vNET should be configured. Restrict outbound access from the service if not required
- Configure global init script to encrypt Data in transit
- Store notebooks in versioned-controlled Git repositories
- Use Managed Identities/Service Principals to access other resources
- Ensure that secrets and credentials are stored in secure locations such as Azure Key Vault, instead of embedding them into code or configuration files.
- Use Azure Role-Based Access Control (Azure RBAC) to manage access to the service's data plane actions
- Segregate Admin users from daily activity users via RBAC
- Workspace admins should use the RBAC to control access to workspaces and prevent shell usage
- Manually restart the cluster periodically (once per week) so that the used images will have the latest Operating System patches. Databricks does not do this automatically.
- Use Terraform providers `azurerm` and [`databricks`](https://registry.terraform.io/providers/databricks/databricks/latest/docs) to configure both the cluster and the Databricks workspace

!!! tip "For initial provisioning"

    When accessing databricks workspace after it has been provisioned via terraform, make sure to have been assigned the Contributor or Owner role. When selecting the **Launch Workspace** button in the databricks overview dashboard, any user with Contributor or Owner role will be created as an admin in the workspace.

## Enforced Policies

{{ display_azure_policies('databricks') }}

## Terraform example

Coming soon
