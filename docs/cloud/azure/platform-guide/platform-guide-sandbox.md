# What's a Sandbox Environment?

A Sandbox is a self-contained time-limited Azure environment (subscription) that can be used for exploration and prototyping Azure resources. Sandbox environments are isolated from other environments and landing zones, thus it does not provide connectivity to the Henkel corporate network, nor peering with other Azure environments.

A Sandbox Environment is provided upon request. To request a Sandbox Environment a [Cloud Portal Ticket](../../cloud-portal-catalogrequest.md) should be raised.

Deploying resources in the sandbox is limited to only exploration and investigatory activities. Sandbox environments are ideal for developers and Henkel business that wants to explore a new Azure service or assess an Azure service before proceeding with actual development. Sandbox environments have fewer restrictions than other Azure environments to allow more free exploration.

!!! warning "Data connection restrictions"

    An important restriction is that a sandbox environment must not be connected with live data sources, i.e. APIs, databases, production systems outside of the environments. When working with data in a sandbox environment, a third-party data source must either be mocked or consumed from an offline data dump loaded to the Sandbox environment.

Below, further details of a Sandbox environment are explained in the context of Henkel.

## Henkel Azure Sandbox

Overall, the following parts are provided as part of a Henkel Azure Sandbox:

1. Azure Subscription
2. Access Management
3. Central Logging
4. Guardrails

### 1. Azure subscription

An Azure Dev/Test subscription is provided together with the Sandbox. This subscription is time-limited and will as a default expire **3 months** after it is created.
You can once request an extension of the sandbox for one more month to have a grace period to migrate resources from the subscription to a non-sandbox subscription.
Please raise a ticket in the [Cloud Portal](https://cloudportal.henkelgroup.cloud/#/) as child ticket to the original ticket to request the extension.

A budget restriction feature **is planned** for the future where each Sandbox subscription has a limited budget of €125 per month. A subscription will be disabled for the rest of the month once the allocated budget has been used.
Currently, there is no budget restriction, but of course we ask you to save costs and deploy and/or keep running only necessary services.

A Dev/Test subscription is a special type of subscription used for testing purposes. This type of subscription does not provide any SLA, but it provides lower rates for some services. Only active Visual Studio subscribers can use the Azure resources running within the Sandbox subscription. Please refer to [Enterprise Dev/Test](https://azure.microsoft.com/en-us/pricing/offers/ms-azr-0148p/?cdn=disable) for more details on Dev/Test subscriptions.

### 2. Access Management

An existing myID AAD Group is required as part of the creation of a Sandbox Environment. This myID AAD Group is assigned the custom role _Sandbox App Developer_. PIM is required for activating the _Sandbox Subscription Owner_ role. No approval is required.

The two custom Azure RBAC roles are built on-top of standard Azure roles:

| Role                       | Description                                                                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Sandbox App Developer      | Based on the built-in _[Contributor](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#contributor)_ role in Azure |
| Sandbox Subscription Owner | Based on the built-in _[Owner](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#owner)_ role in Azure             |

The custom roles bear certain restrictions (`notActions`) in comparison with the _Contributor_ and _Owner_ roles, meaning that those actions are not allowed.

```
Microsoft.Subscription/cancel/action,
Microsoft.Subscription/rename/action,
Microsoft.Subscription/enable/action,
```

### 3. Central Logging

The central Log Analytics workspace in the Non-Prod Landing Zone is set up to collect security-related logs from certain services. Policies are in place that will automatically set this up. For application logs, the individual teams need to set up their own Log Analytics workspace.

### 4. Guardrails / Azure Policies

For helping to keep the workloads in Azure safe and in compliance with the Henkel security standards, Sandbox environments are guarded by guardrails in the form of Azure Policies. These policies might deny certain actions and resources.

Please read through the following sections to learn which guardrails are in place as this can have an impact on the architecture of workloads.

#### Disallowed resources

To keep the Sandboxes self-contained a series of resources have been disallowed on all Sandbox subscriptions. These resources are disallowed to remove the possibility of connecting a Sandbox environment with any on-premises Henkel resources.

{{ read_json_if_exists('docs/cloud/azure/data/policies/sandbox/DisallowedResources.json') }}

#### Virtual network peerings

Virtual network peerings are disallowed in the Sandbox environments to prevent the possibility of accessing any production workloads. Any resources which require private connectivity to each other in your Sandbox environment, therefore, need to be in the same virtual network.

#### Allowed Regions

Resource groups can be deployed to the following regions:

{{ read_json_if_exists('docs/cloud/azure/data/policies/sandbox/AllowedRegionsForResourceGroups.json') }}

Resources can be deployed to the following regions:

{{ read_json_if_exists('docs/cloud/azure/data/policies/sandbox/AllowedRegions.json') }}

Resources that use the _global_ region are allowed.

#### Disallowed Role Definitions

The following role definitions cannot be assigned:

{{ read_json_if_exists('docs/cloud/azure/data/policies/sandbox/DisallowedRoleDefinitions.json') }}

#### Defender for Cloud

The following policies are in place as part of Defender for Cloud:

{{ read_json_if_exists('docs/cloud/azure/data/policies/sandbox/defender.json') }}

#### Network

{{ read_json_if_exists('docs/cloud/azure/data/policies/sandbox/network.json') }}

#### Other Policies

These policies are also in place:

{{ read_json_if_exists('docs/cloud/azure/data/policies/sandbox/Other.json') }}

In addition, please see the list of enforced policy for specific resources under the [Service Enablement on Azure](../sef/introduction.md).

### 5. Frequently asked questions (FAQ)

#### Are all Henkel businesses allowed to raise request for Sandbox ?

Yes, all Henkel business units are allowed raise request for Sandbox

#### Am I allowed to move my services/data/images from sandbox to other environments (to test/dev/prod subscriptions) before my Sandbox subscription retires or once I am done with the protyping ?

No. We encourage you to do the Cloud Engineering in automated way (example, by using Terraform script) so that the your cloud landscape can be deployed many-times, this eliminates the need of migration.

#### Can my prototype that built on Sandbox be rolled out to customers/external users for testing/ or UAT purpose?

No, the prototype that built on sandbox is not supposed to roll-out to external users or customers as Sandbox is intended only for exploration and investigatory activities. If you have a roll-out use case, we encourage you to leverage either non-production or production subcriptions depends on the use case.

#### Can App registration be possible with resources in my Sandbox subscription that requires consent from AD team?

Yes but keep it in mind that the resources in Sandbox subscription that leverages Application registration credentials lasts only until Sandbox's expiry date
