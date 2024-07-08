# Azure Machine Learning

```
Microsoft.MachineLearningServices/*
```

## Minimum required configuration

- Azure ML and supporting services should be provisioned in a vNET along with respective private endpoints.
[See Microsoft documentation](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-secure-workspace-vnet?view=azureml-api-2&tabs=required%2Cpe%2Ccli)
- If the services have exposed public APIs endpoint for consumption, a service which supports WAF should be used in front (e.g. App gateway, Front Door)
- Make sure the clients that are connecting to the ML endpoints support TLS 1.2
- Data at rest is by default encrypted with Service-managed keys. If sensitive data is to be handled, consider using Customer-managed keys.
- Use `HBI_workspace` flag to enable Azure Disk Encryption on the underlying virtual machines' disks.
- Use System-Assigned Identities for authentication to other data sources. Provide just-enough access for the identity on the target service.
- Consider backup strategy for the underlying service if the data is stored in dependent services (Storage, SQL database, etc.).
- Frequently recycle the Compute nodes to get the newest base image. MS publishes a new OS image every month

## Enforced Policies

{{ display_azure_policies('aml') }}

## Notes

- Notice that the `App Developer` role is assigned to the `user assigned managed identity` in the below Terraform example. This is due to the `Contributor` role being disallowed in the Landing Zones.

## Terraform example

``` terraform linenums="1"
--8<-- "templates/machine_learning_workspace/main.tf"
```
