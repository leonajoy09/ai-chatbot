## GCP project factory

# Project Factory Definition Repository Usage

## Purpose

Use this repo to provision projects using the project factory templates located in the `project-factory-henkel` repository.

All configuration.yaml files added to this repo under the `henkelcom/` folder will be planned and potentially applied on successful merge.

The project factory code repo is environmental and organizational independent, and will use the environment files from this repo as the config.

For example, a file where the `type : dev-dmz` will provision a project using the `terraform.tfvars` file from `environments/dev-dmz/terraform.tfvars`

### Prerequisite knowledge needed to provision projects

- Access to the template file for project configuration
- Access to the project factory configuration repo (create branch, merge branch)
- Access to the Gitlab instance
  
---
## Deleting a Provisioned Project

1. Delete all resources inside the provisioned projects
2. Create a branch in the configuration repo
3. Set the flag `create_project : false` in your project config
4. Create a merge request
5. Review the plan and approve the merge
6. Do not attempt to delete the YAML file, this will not work.
   


The following flags will affect individual parts of the project, but the `create_project` flags will delete everything

```yaml
    create_project       : true                       # Flag for base project creation. Will stop creation of any resources if set to false
    create_subnet        : true                       # Flag for subnet creation with manual IP range assignment
    create_os_patch      : true                       # Flag for OS Patch Manager
    create_iac_project   : false                      # DEPRECATED. Flag for IaC project creation
    create_tag           : true                       # Flag for tag(s) creation
    create_budget        : true                       # Flag for budget creation
```
---
## Provisioning a Project

To provision a project you need to provide a file in `.yaml` format, and a template will be provided in sharepoint (review the resource section).

After filling out the `.yaml` using the template, create a `request/<name>` branch, and upload your file to the branch. Create a merge request and wait for centralized approval process.
The merge request pipeline that is triggered will present the plan. If anything fails, you can close the merge request and fix any problems manually.

---
## Current Limitations

Each time the pipeline runs with a valid definition file, a unique prefix is made in the bucket for the tfstate file. This is dynamically created, but is not dynamically deleted. The prefix will continue to exist in the bucket with an empty state file until it is manually deleted.

- In Gitlab, you cannot squash commit, as it is always looking at the HEAD of the branch or git diff.
- All labels and key/value pairs must be in small caps

---
## GCP Compute Instance - Multiple Patch Schedules (Weekly, Monthly etc)

Prerequisite - ensure that you are using Project factory version v1.14.3 and above 
```yaml 
# yaml-language-server: $schema=https://storage.googleapis.com/hmcp-gcp-platform-schemas/project-factory/v1.14.3/project-environment-schema.json
```
Define the patch config section/block as below to support multiple patch schedules.
```yaml 
# OS Patch Manger, Nothing needed to be changed in this block. Make flag true to enable OS Patch Manager
  patch_config:
    mig_instances_allowed               : false    # Set this true if your instances are running as part of MIG.
    apt_type                            : "DIST"
    duration                            : "21600s"
    yum_security                        : true
    yum_minimal                         : true
    windows_classifications             : [ "CRITICAL", "SECURITY", "SERVICE_PACK" ]
    rollout_mode                        : "ZONE_BY_ZONE"
    rollout_disruption_budget_percentage: "25"
    recurring_schedule_timezone_id      : "Europe/Berlin"
    schedule:
      - patch_deployment_id                         : "patch-deploy-weekly"
        schedule_type                               : "weekly"
        reboot_config                               : "DEFAULT"          # DEFAULT, ALWAYS, and NEVER.  
        recurring_schedule_timezone_hours           : "3"
        recurring_schedule_weekly_timezone_day      : "SUNDAY"
        instance_filter_label                       : "all"              #Applies to all instances 
      - patch_deployment_id                         : "patch-deploy-monthly"
        schedule_type                               : "monthly"
        reboot_config                               : "DEFAULT"           # DEFAULT, ALWAYS, and NEVER.
        recurring_schedule_timezone_hours           : "3"
        recurring_schedule_monthly_week_day         : "SUNDAY" 
        recurring_schedule_monthly_week_ordinal     : "3"
        instance_filter_label                       : "monthly-sunday"    #Applies to instances with label "monthly-sunday"
```

---
## Provisioning groups

Google Cloud Platform uses groups synced from Azure Entra ID to manage identities. As part of the project factory, it is possible to create groups or in certain scenarios use an existing group to gain access to the GCP console. To set up configuration for this, under the specific workload folder, create a folder named `core`. Inside the folder, create a file named `config.yaml`, the directory structure should look like:

```bash
henkelcom/cv-sndbx-de
|-- core
|   `-- config.yaml
`-- test
    `-- omkar-cvation-demo.yaml
```

In the `config.yaml` file, write the configuration following the structure:

```yaml
<YOUR-PROJECT-NAME>: 
  name: <YOUR-PROJECT-NAME> 
  app_id: <YOUR-APP-ID>
  groups:
    create_default_groups:
      myid:
        owner: <APP-OWNER-EMAIL>@henkel.com
        admins: 
          - <ADMIN-1-EMAIL>@henkel.com
          - <ADMIN-1-EMAIL>@henkel.com
    existing_groups:
      - <EXISTING-GROUP-NAME>
```

Example configuration:

```yaml
cv-sndbx: 
  name: cv-sndbx 
  app_id: APP-40212
  groups:
    create_default_groups:
      myid:
        owner: omkar.o.sonawane@henkel.com
        admins: 
          - johannes.bertoft@henkel.com
          - omkar.o.sonawane@henkel.com
    existing_groups:
      - APP-GCP-myid-test-group
```
The block `create_default_groups` define the configuration for three new groups that will be created in MyID. The configuration is only for initial configuration, and subsequent changes needs to be handled via the MyID portal. The three groups created will be of the form:

- `APP-GCP-<YOUR-PROJECT>-developers`
- `APP-GCP-<YOUR-PROJECT>-managers`
- `APP-GCP-<YOUR-PROJECT>-team`

Assigning members to the groups should be handled by the owner/admin through the MyID portal. The groups are automatically assigned to the Azure Enterprise Application `Google Cloud (Provisioning)` and subsequently synced to Google Cloud (with an approximate 45 min delay).


#### Requirements

- The App-ID needs to be a valid app id in Alfabet
- The owner needs to be an internal Henkel employee
- At least two admins must be assigned, one of which must be an internal Henkel employee (can be the same as the owner).
- Any existing groups defined must already exist in MyID / Azure Entra ID, and should only be used for special scenarios.

---
## IPAM

- IPAM is running as terraform provider. GCP Project factory uses IPAM TF provider to automatiyally assign the available IP address range to the subnet based on inputted subnet mask value as part of project/subnet provisioning step. 

-	IPAM functionality in the GCP project factory automatically assigns the IP address to the app subnet. Need to set below flags/configs in the project factory yaml file – Subnet block/section as below:

```yaml 
  subnets:
    - region: "europe-west3"
      subnets:
        - name: "test-prod-subnet-01"
          subnet_description: "Subnet for test app in europe-west3"
          subnet_mask: 29
          is_kyndryl: true. ## This boolean flag with value true is mandatory for Kyndryl migrated workloads. 
          private_ip_google_access: true
```

- IPAM does this IP auto assignment from the reserved IP addresses ranges which are maintained by Platform team here - https://henkelgroup.sharepoint.com/:x:/r/teams/MST-C-HybridCloud/Shared%20Documents/General/500%20Operations/GCP%20Operations/GCP_HENKELCOM_VPC_SUBNETS.xlsx?d=w19ae63b2358f4fc08b43d4ef4a2f2425&csf=1&web=1&e=aE9XCj 

---
## Project Factory Documentation - Henkel.com

### Maturity Level: 1.1

#### Features

- IaC and workload projects
- Support for flags to determine what is created
- VM workloads
- GKE workloads
- Custom Firewall rules
- Custom IAM bindings
- Custom IaC project repo admins
- Premade template files for IaC repo
- Subnet creation with support for secondary ranges

### Bootstrapping the projects




## Project Factory Validator

- Project factory validator runs as a separate pipeline job in the Gitlab pipeline. It runs before provisioning the project.This validation steps allows to eliminate any incomplete/incorrect details which is mandatory/important for any GCP Project from Finance, Governace, Security point of view. 
- Validator performs validation of the project definition yaml file against the predefined json schema file to ensure all the inputs inside the  project definition yaml file are appropriatly setup. e.g. project labels, subnet block definition, os patch block definition etc. 
  

## Resources

- [Labeling Scheme](https://henkelgroup.sharepoint.com/:x:/r/teams/MST-C-HybridCloud/_layouts/15/Doc.aspx?sourcedoc=%7B1ab0efd7-ec15-4351-b280-a9a54765e335%7D&action=default&uid=%7B1AB0EFD7-EC15-4351-B280-A9A54765E335%7D&ListItemId=560&ListId=%7BE344B430-CAE8-4065-93D9-6C328B3CBC52%7D&odsp=1&env=prod)
- [Naming conventions](https://henkelgroup.sharepoint.com/:x:/r/teams/MST-C-HybridCloud/_layouts/15/Doc.aspx?sourcedoc=%7BFB135C34-283E-482B-BC39-3605B38FBC60%7D&file=Henkel%20GCP%20Naming%20Conventions%20-%20v1.1.xlsx&action=default&mobileredirect=true)
- [VPC Subnets](https://henkelgroup.sharepoint.com/:x:/r/teams/MST-C-HybridCloud/_layouts/15/Doc.aspx?sourcedoc=%7B19AE63B2-358F-4FC0-8B43-D4EF4A2F2425%7D&file=GCP_HENKELCOM_VPC_SUBNETS.xlsx&action=default&mobileredirect=true)
- [Definition Template](https://henkelgroup.sharepoint.com/teams/MST-C-HybridCloud/Shared%20Documents/Forms/AllItems.aspx?id=%2Fteams%2FMST%2DC%2DHybridCloud%2FShared%20Documents%2FGeneral%2F200%20Public%20Cloud%20%2D%20GCP%2FDocumentation%2FProject%20Factory%2FProject%20Factory%20Yaml%20Template%2FYAML%2Dtemplate%2Dv%2E1%2E2%2Eyaml&viewid=d5bd1585%2D5d88%2D49da%2Da08e%2D8c78200cfa54&parent=%2Fteams%2FMST%2DC%2DHybridCloud%2FShared%20Documents%2FGeneral%2F200%20Public%20Cloud%20%2D%20GCP%2FDocumentation%2FProject%20Factory%2FProject%20Factory%20Yaml%20Template)
