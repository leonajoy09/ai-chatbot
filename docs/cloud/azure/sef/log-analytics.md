# Log Analytics Workspace

```
"Microsoft.OperationalInsights/workspaces*
```

## Minimum required configuration

No minimum configuration is demanded for Log Analytics Workspace. The resource can be used with public access.

!!! info "Private Log Analytics Workspace"

    It should not be attempted to make the Log Analytics Workspace private as it would require Azure Monitor Private Linked Scopes (AMPLS). This is a global resource and only one can exist within Henkel's DNS setup. If a private Log Analytics Workspace is required then an isolated DNS setup must be introduced as well for the particular Virtual Network.

!!! info "Disable Local Authentication"

    It is recommended to disable local autentication on the Log Analytics Workspace if possible.
    Please refer to [Disable local authentication for Log Analytics workspaces](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/azure-ad-authentication-logs?tabs=azure-policy#disable-local-authentication-for-log-analytics-workspaces) to understand which functionality is not supported after disabling local authentication.

## Terraform example

``` terraform linenums="1"
--8<-- "templates/loganalytics.tf"
```
