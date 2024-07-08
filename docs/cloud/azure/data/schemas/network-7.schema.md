|Name|Type|Description|
|----|----|-----------|
|`$schema`|`string`|    |
|[`vnets`](#vnets)|`object[]`|  Configuration of the virtual networks (VNets) within a single environment.  |


## `vnets`
|Name|Type|Description|
|----|----|-----------|
|`application_security_groups`|`string[]`|(Required)  ASGs that can be used for NSG rules. Only lowercase alphanumeric characters are allowed, e.g. `jumpserver01`.  |
|[`azure_backup`](#vnetsazure_backup)|`object`|  Configuration of network integration to Azure Backup.<br><br>**Note:** Azure Backup needs to be enabled in every VNet where VM backup is required.  |
|[`bastion`](#vnetsbastion)|`object`|  Configuration of an Azure Bastion.  |
|[`build_agent`](#vnetsbuild_agent)|`object`|  Configuration of the self-hosted build agents.  |
|`connect_to_hub`|`boolean`|  Option for connecting the VNet to the Virtual Hub. This provides access to the Henkel internal network and other workloads in Azure. <br><br>Default value: `false` |
|[`default_nsg_extra_rules`](#vnetsdefault_nsg_extra_rules)|`object`|    |
|`enable_deprecated_network_resources`|`boolean`|  Option to toggle if the deprecated NSG rules and ASGs from the Skaylink VNet module should be set. <br><br>Default value: `false` |
|`enable_flow_logs`|`boolean`|  Option for enabling flow logs for the VNet. A Storage Account and a Log Analytics Workspace will be provisioned for persisting the flow logs <br><br>Default value: `false` |
|`ip_ranges`|`string[]`|(Required)  The IP ranges of the VNet. The IP ranges are currently provided by the Azure Platform team. Note that changes to the IP ranges can require reprovisioning of resources and downtime while the connection to the Virtual Hub is re-created.  |
|`legacy_application_security_groups`|`string[]`|  Names of legacy non-default ASGs that should be imported for a migrated legacy VNet.  |
|`legacy_vnet_imported`|`boolean`|  Option to mark the the import of a legacy VNet as completed and thereby skipping the import job.  |
|`legacy_vnet_name`|`string`|  The name of an existing legacy VNet. The property is used for migration to a new Landing Zone setup.  |
|`legacy_vnet_rg`|`string`|  The resource group of an existing legacy VNet. The property is used for migration to a new Landing Zone setup.  |
|`location`|`string`|(Required)  The Azure region where the VNet should be deployed. Resources integrated with the VNet will need to be located in the same region.  <br><br>Allowed values: `australiaeast, eastus, germanywestcentral, southeastasia, westeurope`|
|`nat_gateways`|`object`|  Configuration of NAT gateways that can be used by the subnets. The name must be lowercase alphanumeric only, e.g. `natgw01`.  |
|[`network_security_groups`](#vnetsnetwork_security_groups)|`object{}`|(Required)  The NSGs available to the VNet. The NSG names `default`, `bas`, and `buildagent` are reserved by the platform and can't be used.  |
|[`private_dns_zones`](#vnetsprivate_dns_zones)|`object[]`|  Configuration of Private DNS Zones.  |
|`short_name`|`string`|  Short name to identify a specific VNet. Short name and location combination must be unique within the environment. It is only necessary to set this property, if multiple VNets are needed in the same location and environment.. <br><br>Default value: `net` |
|[`subnets`](#vnetssubnets)|`object{}`|(Required)  Configuration of the subnets in the VNet  |


## `vnets.azure_backup`
|Name|Type|Description|
|----|----|-----------|
|`subnet`|`string`|(Required)  The name of the subnet where a Private Endpoint for Azure Backup will be set up. The subnet must have available space for at least 10 IP's.  |


## `vnets.bastion`
|Name|Type|Description|
|----|----|-----------|
|`ip_connect_enabled`|`boolean`|  Option to enable the IP Connect feature on the Bastion. Requires that the Bastion SKU is `Standard`. <br><br>Default value: `false` |
|`ip_range`|`string`|(Required)  The subnet range for the subnet where the Bastion is deployed. Must be `/26` or larger.  |
|`sku`|`string`|  The SKU of the Bastion. <br><br>Default value: `Basic` <br><br>Allowed values: `Basic, Standard`|


## `vnets.build_agent`
|Name|Type|Description|
|----|----|-----------|
|`application_security_groups`|`string[]`|  A list of ASGs to associate to the build agents. Note that the ASGs must also be listed in `vnet.application_security_groups`.  |
|`bypass_agentpool_creation`|`boolean`| (Deprecated) Option to bypass the creation and validation of the agent pool. This option was added to support backwards compatibility, but should not be used for new build agents. <br><br>Default value: `false` |
|`ip_range`|`string`|(Required)  The subnet IP range of the build agents attached to the VNet.  |
|`ms_image`|`string`|  The Microsoft Build Agent Image to be used on the build agents. If no value is provided, then a basic Ubuntu image is used.  <br><br>Allowed values: `Ubuntu22`|


## `vnets.default_nsg_extra_rules`
|Name|Type|Description|
|----|----|-----------|
|[`inbound`](#vnetsdefault_nsg_extra_rulesinbound)|`{}`|  Extra inbound rules added to the default NSG.  |
|[`outbound`](#vnetsdefault_nsg_extra_rulesoutbound)|`{}`|  Extra outbound rules added to the default NSG.  |


## `vnets.default_nsg_extra_rules.inbound`
|Name|Type|Description|
|----|----|-----------|
|`access`|`string`|(Required)  Specifies whether the rule allows or denies traffic.  <br><br>Allowed values: `Allow, Deny`|
|`description`|`string`|  A description for the rule that should clarify the intention.  |
|`destination_address_prefix`|`string`|  CIDR or destination IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `destination_address_prefixes` is not specified.  |
|`destination_address_prefixes`|`string[]`|  List of destination address prefixes in CIDR or destination IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `destination_address_prefix` instead.  |
|`destination_application_security_groups`|`[]`|  List of destination ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`destination_port_range`||  Destination port or port range.  |
|`destination_port_ranges`|`[]`|  List of destination ports or port ranges.  |
|`priority`|`integer`|(Required)  Priority of the rule. The priority number must be unique for each rule in the collection. The lower the priority, the higher the priority of the rule. The priorities `100-299` and `4096` are reserved by the platform.  |
|`protocol`|`string`|(Required)  Protocol of the rule. `*` matches all protocols.  <br><br>Allowed values: `*, Ah, Esp, Icmp, Tcp, Udp`|
|`source_address_prefix`|`string`|  CIDR or source IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `source_address_prefixes` is not specified  |
|`source_address_prefixes`|`string[]`|  List of source address prefixes in CIDR or source IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `source_address_prefix` instead.  |
|`source_application_security_groups`|`[]`|  List of source ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`source_port_range`||  Source port or port range.  |
|`source_port_ranges`|`[]`|  List of source ports or port ranges.  |


## `vnets.default_nsg_extra_rules.outbound`
|Name|Type|Description|
|----|----|-----------|
|`access`|`string`|(Required)  Specifies whether the rule allows or denies traffic.  <br><br>Allowed values: `Allow, Deny`|
|`description`|`string`|  A description for the rule that should clarify the intention.  |
|`destination_address_prefix`|`string`|  CIDR or destination IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `destination_address_prefixes` is not specified.  |
|`destination_address_prefixes`|`string[]`|  List of destination address prefixes in CIDR or destination IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `destination_address_prefix` instead.  |
|`destination_application_security_groups`|`[]`|  List of destination ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`destination_port_range`||  Destination port or port range.  |
|`destination_port_ranges`|`[]`|  List of destination ports or port ranges.  |
|`priority`|`integer`|(Required)  Priority of the rule. The priority number must be unique for each rule in the collection. The lower the priority, the higher the priority of the rule. The priorities `100-299` and `4096` are reserved by the platform.  |
|`protocol`|`string`|(Required)  Protocol of the rule. `*` matches all protocols.  <br><br>Allowed values: `*, Ah, Esp, Icmp, Tcp, Udp`|
|`source_address_prefix`|`string`|  CIDR or source IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `source_address_prefixes` is not specified  |
|`source_address_prefixes`|`string[]`|  List of source address prefixes in CIDR or source IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `source_address_prefix` instead.  |
|`source_application_security_groups`|`[]`|  List of source ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`source_port_range`||  Source port or port range.  |
|`source_port_ranges`|`[]`|  List of source ports or port ranges.  |


## `vnets.network_security_groups`
|Name|Type|Description|
|----|----|-----------|
|`disable_default_outbound_rules`|`boolean`|  Option to disable the default outbound rules in the NSG. This is required for instance if Application Gateway will be deployed. <br><br>Default value: `false` |
|[`inbound`](#vnetsnetwork_security_groupsinbound)|`{}`|(Required)  The inbound NSG rules of the NSG  |
|`is_legacy_nsg`|`boolean`|  Option to toggle if the NSG is an existing NSG when migrating a legacy VNet. <br><br>Default value: `false` |
|[`outbound`](#vnetsnetwork_security_groupsoutbound)|`{}`|(Required)  The outbound NSG rules of the NSG  |


## `vnets.network_security_groups.inbound`
|Name|Type|Description|
|----|----|-----------|
|`access`|`string`|(Required)  Specifies whether the rule allows or denies traffic.  <br><br>Allowed values: `Allow, Deny`|
|`description`|`string`|  A description for the rule that should clarify the intention.  |
|`destination_address_prefix`|`string`|  CIDR or destination IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `destination_address_prefixes` is not specified.  |
|`destination_address_prefixes`|`string[]`|  List of destination address prefixes in CIDR or destination IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `destination_address_prefix` instead.  |
|`destination_application_security_groups`|`[]`|  List of destination ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`destination_port_range`||  Destination port or port range.  |
|`destination_port_ranges`|`[]`|  List of destination ports or port ranges.  |
|`priority`|`integer`|(Required)  Priority of the rule. The priority number must be unique for each rule in the collection. The lower the priority, the higher the priority of the rule. The priorities `100-299` and `4096` are reserved by the platform.  |
|`protocol`|`string`|(Required)  Protocol of the rule. `*` matches all protocols.  <br><br>Allowed values: `*, Ah, Esp, Icmp, Tcp, Udp`|
|`source_address_prefix`|`string`|  CIDR or source IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `source_address_prefixes` is not specified  |
|`source_address_prefixes`|`string[]`|  List of source address prefixes in CIDR or source IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `source_address_prefix` instead.  |
|`source_application_security_groups`|`[]`|  List of source ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`source_port_range`||  Source port or port range.  |
|`source_port_ranges`|`[]`|  List of source ports or port ranges.  |


## `vnets.network_security_groups.outbound`
|Name|Type|Description|
|----|----|-----------|
|`access`|`string`|(Required)  Specifies whether the rule allows or denies traffic.  <br><br>Allowed values: `Allow, Deny`|
|`description`|`string`|  A description for the rule that should clarify the intention.  |
|`destination_address_prefix`|`string`|  CIDR or destination IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `destination_address_prefixes` is not specified.  |
|`destination_address_prefixes`|`string[]`|  List of destination address prefixes in CIDR or destination IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `destination_address_prefix` instead.  |
|`destination_application_security_groups`|`[]`|  List of destination ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`destination_port_range`||  Destination port or port range.  |
|`destination_port_ranges`|`[]`|  List of destination ports or port ranges.  |
|`priority`|`integer`|(Required)  Priority of the rule. The priority number must be unique for each rule in the collection. The lower the priority, the higher the priority of the rule. The priorities `100-299` and `4096` are reserved by the platform.  |
|`protocol`|`string`|(Required)  Protocol of the rule. `*` matches all protocols.  <br><br>Allowed values: `*, Ah, Esp, Icmp, Tcp, Udp`|
|`source_address_prefix`|`string`|  CIDR or source IP range or `*` to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `source_address_prefixes` is not specified  |
|`source_address_prefixes`|`string[]`|  List of source address prefixes in CIDR or source IP ranges. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can not be used. See `source_address_prefix` instead.  |
|`source_application_security_groups`|`[]`|  List of source ASGs. It can either be one of the default groups or match one of the ASGs defined in the `application_security_groups` block or the `legacy_application_security_groups` block.  |
|`source_port_range`||  Source port or port range.  |
|`source_port_ranges`|`[]`|  List of source ports or port ranges.  |


## `vnets.private_dns_zones`
|Name|Type|Description|
|----|----|-----------|
|`domain`|`string`|(Required)  The name of the Private DNS Zone, e.g. `<env>.<domain>.az.henkelgroup.io`. Currently the following base domains are allowed: `az.henkelgroup.io`, `henkelgroup.io`, `privatelink.<regionName>.azmk8s.io`, `private.postgres.azure.com` and `mysql.database.azure.com`. We recommend using `{environment}.{domain}.az.henkelgroup.io` as Conditional Forwarding is already configured for the `az.henkelgroup.io` DNS Zone.  |
|`link_to_conn_vnet`|`boolean`|  Option to link the Private DNS Zone to the central connectivity VNet. This is needed for Henkel's on-prem DNS server to resolve entries in the Private DNS Zone. <br><br>Default value: `false` |
|`link_to_vnet`|`boolean`|  Option to link the Private DNS Zone to the VNet. This is needed in scenarios where it's an Azure Resource requirement, or if the VNet is not connected to the Virtual Hub. <br><br>Default value: `false` |


## `vnets.subnets`
|Name|Type|Description|
|----|----|-----------|
|`attach_route_table`|`boolean`|  Option to attach a route table to the subnet. <br><br>Default value: `false` |
|`ip_range`|`string`|(Required)  The IP range of the subnet. The IP range must be within one of the VNet IP ranges. The IP range can only be changed, if there are no resources deployed into the subnet.  |
|`nat_gateway`|`string`|  The NAT gateway which should be associated with the subnet. It should match one of the declared NAT gateways in `nat_gateways`.  |
|`network_security_group_name`|`string`|  The name of the NSG that should be attached to the subnet. If no value is provided, then the `default` NSG will be attached. If set to `null` no NSG will be attached to the subnet. <br><br>Default value: `default` |
|`private_endpoint_network_policies_enabled`|`boolean`|  Option to disable Private Endpoint Network Policies for Private Endpoints in the subnet. It should only be set to `false` in exceptional cases. <br><br>Default value: `true` |
|`private_link_service_network_policies_enabled`|`boolean`|  Option to disable Service Network Policies for the Service Endpoints in the subnet. It should only be set to `false` in exceptional cases. <br><br>Default value: `true` |
|`service_delegation`|`string`|  The name of service to which the subnet should be delegated, e.g. `Microsoft.Web/serverFarms`. Please refer to the Cloud Docs or the Microsoft Documentation for information regarding which services require service delegation.  |
|`service_delegation_actions`|`string[]`|  The actions delegated to the service, e.g. `Microsoft.Network/virtualNetworks/subnets/action`. Please refer to the Cloud Docs or the Microsoft Documentation for information regarding which services require service delegation.  |
|`service_endpoints`|`string[]`|  A list of Service Endpoints to be associated with the subnet.  |


