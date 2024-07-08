# Azure Logic Apps

```
Microsoft.LoadTestService
Microsoft.LoadTestService/*
```

## Minimum required configuration

No mimimum requirements for the Load Testing Service.

## Recommendations

- Secrets should not be inserted directly into the Load Tests as clear text. Use Azure KeyVault to store secrets.
- The Load Testing Service have RBAC roles for Data Plane operations. The "Load Test Reader" and "Load Test Contributor" should only be granted to identities requiring actions on the Load Tests.

## Enforced Policies

{{ display_azure_policies('lt') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/loadtesting.tf"
```