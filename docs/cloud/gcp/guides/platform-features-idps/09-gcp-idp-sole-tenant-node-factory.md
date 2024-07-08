## GCP Sole Tenant Node factory

# Node Group Factory

## Getting Started

To implement backup plans using the Backup Factory, follow these steps:

1. **Create node group configuration**
    - Clone the repository (e.g. `git clone https://gitlab.gcp.henkelgroup.io/hmcp-gcp/node_group_factory.git`) and create a feature branch.
    - Create a new `.yaml` configuration file in the `config` folder. A schema is provided to give some syntax highlighting for available values (see [documentation reference](config-reference.md))

2. **Create a Merge Request (MR) on GitLab:**
   - Create an MR in the repository with the changes. This will run a validation pipeline to check that everything is configured appropriately. Once the MR is approved the node group(s) will be deployed.

3. **Onboard virtual machines**
   - To create a VM on the node group add the following Node affinity labels under Sole tenancy:
        - `compute.googleapis.com/project:IN:hmcp-share-nodes-de-prj-fd9`
        - `compute.googleapis.com/node-group-name:IN:[INSERT NODE GROUP NAME HERE]`


## Best practices
In general we should try to limit the number of node groups to avoid having many underutilized nodes. In addition to this autoscaling and CPU overcommit can be excellent tools for decreasing costs. That being said we need to ensure that the following best practices are being followed:

- For general purpose workloads use the n2 SKU family.
- Workloads should be seperated by environment. Thus we should strive to not have prod VMs running on the same node groups as dev or test VMs. This is best accomplished by sharing a node group only with projects in the appropriate environment: dev, test or prod.
- For workloads that require constant uptime make sure to use a host maintenance policy that uses live migration for host maintenance events e.g. `MigrateAcrossNodeGroups` or `MigrateWithinNodeGroup`.
- For performance critical workloads we should make sure to disable CPU overcommit to avoid throttling the CPU performance unexpectedly.

## Config Reference  

| Name | Property details| Description | Allowed Values | Remarks |
|----------|----------|----------|----------|----------|
|`node_groups`| ![Static Badge](https://img.shields.io/badge/array-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |The list of node groups that should be created.|||
|`node_groups[]`| ![Static Badge](https://img.shields.io/badge/object-yellow)  ||||
|`node_groups[].zone`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The zone where the node group should be located.|`europe-west3-a, europe-west3-b, europe-west3-c, us-east4-a, us-east4-b, us-east4-c, asia-southeast1-a, asia-southeast1-b, asia-southeast1-c`|VMs running on the node group must be located on the same zone.|
|`node_groups[].environment`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The environment of the node group workloads.|`dev, test, prod`|Please share the node group only with projects in the appropriate environment.|
|`node_groups[].sku`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The sku of the node group nodes.|`c3d-node-360-708, c3-node-176-352, c2-node-60-240, g2-node-96-384, m1-node-96-1433, m2-node-416-11776, m3-node-128-1952, n1-node-96-624, n2-node-80-640, n2d-node-224-896`|The VMs running on the node group must use the same SKU family as the node group.|
|`node_groups[].maintenance_policy`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The host maintenance policy to use on the node group.|`Restart, MigrateWithinNodeGroup, MigrateAcrossNodeGroups`||
|`node_groups[].projects`| ![Static Badge](https://img.shields.io/badge/array-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The list of ids of the projects which should be granted access to the node group.|||
|`node_groups[].projects[]`| ![Static Badge](https://img.shields.io/badge/string-yellow)  ||||
|`node_groups[].initial_size`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The initial number of nodes in the node group.|||
|`node_groups[].maintenance_window`| ![Static Badge](https://img.shields.io/badge/object-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |The specifications of the maintenance window of nodes in node group.|||
|`node_groups[].maintenance_window.start_time`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The start time of the four hour maintenance window in UTC time.|`00:00, 04:00, 08:00, 12:00, 16:00, 20:00, Any`|Only applicable if `maintenance_policy` is `MigrateAcrossGroups`.|
|`node_groups[].autoscale_policy`| ![Static Badge](https://img.shields.io/badge/object-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |The specifications of the autoscale policy of the node group. Omit to disable autoscaling.|||
|`node_groups[].autoscale_policy.allow_scale_in`| ![Static Badge](https://img.shields.io/badge/boolean-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |Whether or not to enable automatic deletion of empty nodes.||Only applicable if `maintenance_policy` is `MigrateAcrossGroups`.|
|`node_groups[].autoscale_policy.min_nodes`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The minimum number of nodes to scale in to.|||
|`node_groups[].autoscale_policy.max_nodes`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The maximum number of nodes to scale out to.|||
|`node_groups[].allow_cpu_overcommit`| ![Static Badge](https://img.shields.io/badge/boolean-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |Whether or not to enable cpu overcommit on node cpus.||Can only be true when using n1 or n2 SKU family.|