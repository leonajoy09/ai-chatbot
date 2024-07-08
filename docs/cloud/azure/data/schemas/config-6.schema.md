|Name|Type|Description|
|----|----|-----------|
|`$schema`|`string`|    |
|[`landing_zone`](#landing_zone)|`object`|  Configuration of a Landing Zone.  |


## `landing_zone`
|Name|Type|Description|
|----|----|-----------|
|`app_creator_email`|`string`|(Required)  The Henkel e-mail that will be set as the creator on the provided App Registrations.  |
|`app_id`||(Required)  The Alfabet (EAM) App ID in the format `APP-1234`. Special cases 'POC' and 'NotRegistered' can be used when an Application is a Proof of Concept (POC) or when an Application is not registred in Alfabet (EAM).  |
|`app_owner_email`|`string`|(Required)  The Henkel e-mail that will be set as owner on the provided App Registrations.  |
|[`azure_devops_project`](#landing_zoneazure_devops_project)|`object`|  A Landing Zone can be attached to an Azure DevOps project. This integration provides:<br>1. A service connection for each subscription.<br>2. Access for members of the myID groups.<br>3. Network-integrated build agents.  |
|`business_unit`|`string`|(Required)  The business unit to which the Landing Zone belongs. Note that changes to the business unit affects the naming of Azure resources, so it is not recommended to change the value after the Landing Zone has been provisioned.  <br><br>Allowed values: `dx, dxa, dxc, dxd, dxf, dxm, dxra, dxre, dxri, dxrp, dxs, dxt, dxv, plat`|
|`cloud_portal_ticket_id`|`integer`|(Required)  The related Cloud Portal ticket where the subscriptions belonging to a Landing Zone are listed.  |
|[`environments`](#landing_zoneenvironments)|`object`|(Required)  Configuration of the Azure subscriptions within the three platform environments (`canary`, `nonprod` and `prod`). The `canary` environment is only available for subscriptions belonging to the Azure Platform team.  |
|`management_group_name`|`string`|(Required)  The name of the management group where subscriptions should be placed. For most Landing Zones, `lzcorp` should be selected.  <br><br>Allowed values: `lzcorp, lzcorpskywalker, lzhdp, lzonline, lzonlineskywalker, platconn, platid, platmgmt`|
|[`myid`](#landing_zonemyid)|`object`|(Required)  A number of myID groups will be created as part of a Landing Zone. The initial owner and admins must be set in the configuration, but changes must afterwards be performed inside myID.  |
|`name`||(Required)  Name of the Landing Zone. Must be a alphanumeric lowercase string with a length of 3-10 characters, e.g. `mylz01`.  |
|`template`|`string`|(Required) (Deprecated) The access model for the Landing Zone. `bizdevops` should be used for new Landing Zones.  <br><br>Allowed values: `bizdevops, managed`|
|`terraform_enterprise_project`|`object`|  Configuration of a Terraform Enterprise Project for the Landing Zone. Providing an empty object `{}` means that a project will be provisioned.  |


## `landing_zone.azure_devops_project`
|Name|Type|Description|
|----|----|-----------|
|`apply_permissions`|`boolean`|  Option to grant the myID groups created as part of the Landing Zone access to the Azure DevOps project. <br><br>Default value: `true` |
|`name`|`string`|(Required)  The name of the Azure DevOps project.  |
|`organization`|`string`|(Required)  The name of the Azure DevOps organization where the project is located.  <br><br>Allowed values: `CoEDataScience, hbif, henkel-east-asia, henkel-west-europe, henkeldx, hmanagedcloud`|
|`use_existing`|`boolean`|(Required)  Option to integrate with an existing Azure DevOps project. The property must be set to `true` for projects outside the `hmanagedcloud` organization.  |


## `landing_zone.environments`
|Name|Type|Description|
|----|----|-----------|
|[`canary`](#landing_zoneenvironmentscanary)|`object`|(Required)  Configuration of the Azure subscriptions within the `canary` platform environment. The `canary` environment are only available for subscriptions belonging to the Azure Platform team.  |
|[`nonprod`](#landing_zoneenvironmentsnonprod)|`object`|(Required)  Configuration of the Azure subscriptions within the `nonprod` platform environment. The dev and test workload subscriptions should be placed here.  |
|[`prod`](#landing_zoneenvironmentsprod)|`object`|(Required)  Configuration of the Azure subscriptions within the `prod` platform environment. The prod and prod-like workload subscriptions should be placed here.  |


## `landing_zone.environments.canary`
|Name|Type|Description|
|----|----|-----------|
|[`subscriptions`](#landing_zoneenvironmentscanarysubscriptions)|`object{}`|(Required)    |


## `landing_zone.environments.canary.subscriptions`
|Name|Type|Description|
|----|----|-----------|
|`legacy_subscription_id`|`string`|  The ID of an existing subscription that is imported into a Landing Zone.  |
|[`vm_alerts`](#landing_zoneenvironmentscanarysubscriptionsvm_alerts)|`object`|  Setting this object enables VM alerts on the subscription  |


## `landing_zone.environments.canary.subscriptions.vm_alerts`
|Name|Type|Description|
|----|----|-----------|
|`alert_emails`|`string[]`|(Required)  The Henkel emails that need to receive an email notification if an alert is fired  |
|`locations`|`string[]`|(Required)  The Azure regions where alerts should be enabled. Alerts are regional constructs and should be enabled in regions matching the region where Virtual Machines are deployed  |


## `landing_zone.environments.nonprod`
|Name|Type|Description|
|----|----|-----------|
|[`subscriptions`](#landing_zoneenvironmentsnonprodsubscriptions)|`object{}`|(Required)    |


## `landing_zone.environments.nonprod.subscriptions`
|Name|Type|Description|
|----|----|-----------|
|`legacy_subscription_id`|`string`|  The ID of an existing subscription that is imported into a Landing Zone.  |
|[`vm_alerts`](#landing_zoneenvironmentsnonprodsubscriptionsvm_alerts)|`object`|  Setting this object enables VM alerts on the subscription  |


## `landing_zone.environments.nonprod.subscriptions.vm_alerts`
|Name|Type|Description|
|----|----|-----------|
|`alert_emails`|`string[]`|(Required)  The Henkel emails that need to receive an email notification if an alert is fired  |
|`locations`|`string[]`|(Required)  The Azure regions where alerts should be enabled. Alerts are regional constructs and should be enabled in regions matching the region where Virtual Machines are deployed  |


## `landing_zone.environments.prod`
|Name|Type|Description|
|----|----|-----------|
|[`subscriptions`](#landing_zoneenvironmentsprodsubscriptions)|`object{}`|(Required)    |


## `landing_zone.environments.prod.subscriptions`
|Name|Type|Description|
|----|----|-----------|
|`legacy_subscription_id`|`string`|  The ID of an existing subscription that is imported into a Landing Zone.  |
|[`vm_alerts`](#landing_zoneenvironmentsprodsubscriptionsvm_alerts)|`object`|  Setting this object enables VM alerts on the subscription  |


## `landing_zone.environments.prod.subscriptions.vm_alerts`
|Name|Type|Description|
|----|----|-----------|
|`alert_emails`|`string[]`|(Required)  The Henkel emails that need to receive an email notification if an alert is fired  |
|`locations`|`string[]`|(Required)  The Azure regions where alerts should be enabled. Alerts are regional constructs and should be enabled in regions matching the region where Virtual Machines are deployed  |


## `landing_zone.myid`
|Name|Type|Description|
|----|----|-----------|
|`admins`|`string[]`|(Required)  The Henkel e-mail of the initial admins of the myID groups. At minimum two admins are required, one of which must be a Henkel employee.  |
|`owner`|`string`|(Required)  The Henkel e-mail of the initial owner of the myID groups. The owner must be a Henkel employee.  |


