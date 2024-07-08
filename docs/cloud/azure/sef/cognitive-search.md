# Azure Cognitive Search

```
 	Microsoft.Search/searchServices/*
```

## Minimum required configuration

- Use a SKU that supports private link (Free SKU does not support it).
- Restrict Public Access. 
- Use Private Endpoints to access Search Service.
- Use shared private link for Search to access target resources.
- Target resource of shared private link should be within same subscription.
- Use AzureAD to authenticate.
- Enable resource logs via diagnostic setting.

## Enforced Policies

{{ display_azure_policies('srch') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/search.tf"
```