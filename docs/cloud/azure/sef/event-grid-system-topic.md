# Azure Event Grid - System Topic

```
Microsoft.EventGrid/systemTopics
Microsoft.EventGrid/systemTopics/eventSubscriptions
```

## Important notes

Resources in a vnet can publish events to a System Topic (if it has the correct permissions), but a System Topic cannot delivery these events to resources inside a VNet if they're locked down for public access. 

An example of this could be the Storage Account which has disallowed public access can send events to a system topic. However that system topic cannot deliver these event to the same Storage Account because it has public access disallowed. In order to allow it you will have to allow the specific service as an exception for public access using the namespace and id of the service.

Making exceptions for specific services is disallowed by policies, so in order to be allowed to do that you need to contact [security](../../../security/infrastructure/azure.md#policy-exemptions) to be allowed to do it.

## Minimum required configuration

- Enable system managed identity

## Enforced Policies

{{ display_azure_policies('egst') }}


## Terraform example

``` terraform linenums="1"
--8<-- "templates/systemtopic.tf"
```