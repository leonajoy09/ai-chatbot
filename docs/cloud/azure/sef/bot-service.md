# Azure Bot Service

```
 	Microsoft.BotService/botServices/*
```

## Minimum required configuration

- Restrict Public Access. 
- Use a valid https endpoint.
- Use Private Endpoints to access Bot Service.
- Use AzureBot resource, not the deprecated Bot resource.
- Disable local authentication

## Enforced Policies

{{ display_azure_policies('botservice') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/botservice.tf"
```