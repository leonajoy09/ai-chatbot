# Data Explorer (Kusto)

```
Microsoft.Kusto/clusters
Microsoft.Kusto/clusters/*
```

## Minimum required configuration

- Disk Encryption must be enabled
- Engine & Data Management Public IP resources must be on Standard SKU
- Data Explorer must be exposed behind a private endpoint
- Public access must be disabled
- Purge Protection should be enabled

## Enforced Policies

{{ display_azure_policies('dataexplorer') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/dataexplorer.tf"
```