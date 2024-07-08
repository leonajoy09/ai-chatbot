# Azure AI Services

```
Microsoft.CognitiveServices/accounts/*
```

Azure AI services provide various resources under the same namespace like Custom Vision, ChatGPT, and Document Intelligence. These services are shown as individual services in the Azure Portal. They share the same minimum configuration requirements listed on this page.

## Minimum required configuration

- Public Access must be disabled
- Use Private Endpoints to connect to Azure AI services
- Disable the use of Local Authentication like Static Keys. Instead, authentication must be done [using Entra ID](https://learn.microsoft.com/en-us/azure/ai-services/authentication#authenticate-with-microsoft-entra-id)

### Restrictions on OpenAI

!!! info "Approval required"

    Usage of Azure OpenAI service requires explicit approval for governance reasons. Approval must be sought with Hao Yu <hao.yu@henkel.com>. Upon receiving the approval, please [raise a Cloud Portal request](../../../cloud/cloud-portal.md), attach the proof of approval and ask the Platform Support team to grant the exemption to use OpenAI.

!!! tip "Regional availability"

    Be aware that the Azure OpenAI service is not generally available in all regions. Different GPT models are available to different Azure regions. Please check the Microsoft documentation on model availability [GPT-4 and GPT-4 Turbo Preview model availability](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models#gpt-4-and-gpt-4-turbo-preview-model-availability). When a model is not available in a [supported Landing Zone regions](../platform-guide/platform-guide-landing-zone.md#allowed-regions), please reach out to the dxV architect team through the Hybrid Cloud Portal to ask for guidance on how to proceed.

## Enforced Policies

{{ display_azure_policies('cogserv') }}

## Terraform example

``` terraform linenums="1"
--8<-- "templates/aiservices-customvision.tf"
```