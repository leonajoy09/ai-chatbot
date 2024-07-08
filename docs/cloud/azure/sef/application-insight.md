# Azure Application Insight

```
"Microsoft.Insights/components*
```

## Minimum required configuration

No minimum configuration is demanded for Application Insight. The resource can be used with public access.

!!! info "Private Application Insight"

    It should not be attempted to make the Application Insight private as it would require Azure Monitor Private Linked Scopes (AMPLS). This is a global resource and only one can exist within Henkel's DNS setup. If a private Application Insight is required then an isolated DNS setup must be introduced as well for the particular Virtual Network.

!!! info "Disable Local Authentication"

    It is recommended to disable local autentication on the Log Analytics Workspace if possible.
    Please refer to [Disable local authentication](https://learn.microsoft.com/en-us/azure/azure-monitor/app/azure-ad-authentication?tabs=net#disable-local-authentication) to understand which functionality is not supported after disabling local authentication.

## Terraform example

``` terraform linenums="1"
--8<-- "templates/applicationinsight.tf"
```
