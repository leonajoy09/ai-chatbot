# Naming conventions

## Azure

Following a standard Naming Convention helps organizing resources and identify them in better way. The define naming convention in HMC (Henkel Managed Cloud) is in line with [Microsoft Infrastructure Resource Naming Standards](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging).

The generic pattern to be followed while creating Resources in Henkel Managed Cloud (Azure) as follows:

***Henkel Business Unit-Region-Environment-Project/Product/Application/Workload name-Azure Service name-Instance number***

e.g. 1.  l-weu-prd-coviddtrac-aks-1

- c – Henkel Consumer Brands Business Unit
- weu- West Europe Region
- prd – Production Environment
- coviddtracker – Covide Demand Tracker (Product name)
- aks – Azure Kubernetes Service
- 1- Instance number

e.g. 2.   s-weu-int-pvtdns-acr-1

- s - Shared (It is a shared service that can be consumed by other Henkel projects)
- weu - West Europe
- int - Internal (It is an internal project)
- acr - Azure Container Registry
- 1 - instance number

The following are the possible values under each category:


#### Henkel Business Units

| Henkel Business Unit | Short Name (1 letter) |
|-|-|
| Henkel Consumer Brands (HCB) | c |
| Henkel Adhesive Technology (HAT) | a |
| Cross-functions (HR, SSC,F) | f |
| Shared | s |

### Regions

| Regions  | Short Name (3 letter)  |
|- |- |
| West Europe  | weu  |
| North Europe  | neu  |
| Germany West Central  | gwc  |
| East Asia  | eas  |
| South East Asia  | sea  |
| West US  | wus  |
| Central US  | cus  |
| East US  | eus  |
| East US2  | eu2  |
| Australia East | eau  |

#### Environments

| Environments  | Short Name (3 letter)  |
|- |- |
| Development  | dev  |
| uat  | uat  |
| production  | prd  |
| Internal  | int  |

#### Project/Product/Application/Workload name

| Application/workload  | Short Name (upto 10 letters, keep it short and meaningful)  |
|- |- |
| e.g. SomartSmart  | ssmart  |
| e.g. Video Analytics  | vanalytics  |
| e.g. Private DNS  | pvtdns  |
| e.g. Covid Demand Tracker  | coviddtrack  |

| Resources    |   |
|- |- |
| The naming convention for ressources a frequently updated by Microsoft, therefore please take the following link as a reference: [Microsoft Resource Abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations).   |   |


GCP (Google Cloud Platform)
----------------------------

### Resources Naming Conventiion

#### Benefits

Consistent and descriptive naming of resources has many benefits:

1. Indicates the role and ownership of a resource.
2. Helps formalize expectations and promote consistency within an infrastructure.
3. Prevents name clashes when resource names must be unique.
4. Makes resources easier to locate.
5. Allows to sort and filter resources quickly.
6. Laids out the prerequisite for establishing successful cloud governance and automated policy evaluation or enforcement.

> There are only two hard things in Computer Science: cache invalidation and naming things.
>
> Phil Karlton

#### Main Properties

Good naming convention must provide clarity and work in both directions:

- Clearly define how newly created resources should be named.
- Identify and indicate the purpose and ownership of existing resources.

#### Naming Restrictions

When designing your naming convention, you should take into account limitations imposed by the cloud provider. Each resource comes with a set of naming restrictions. The rule of thumb is to keep it short and simple (use only letters and numbers for individual components, keep - as separator).

#### GCP resource naming convention limits

1. In general resource names must be unique within a location within a project
2. General resource name length for most of the resources be 1-63 characters, Project IDs are limited to 30. **Note:** Hyphens (-) count as two characters.
3. Resources must have unique names, either globally or within a given scope.
4. Few resources have additional constraints to take into consideration (e.g. GCP Projects can’t be immediately deleted).
5. Match the regular expression [a-z]([-a-z0-9]*[a-z0-9])?. This means that the first character must be a lowercase letter, and all the following characters must be hyphens, lowercase letters, or digits, except the last character, which cannot be a hyphen.

#### Generic/Global Naming Pattern

The generic pattern to be followed while creating Resources in Henkel Managed Cloud (GCP) as follows:

***[prefix]-[location]-[environment]-[project]-[resource]-[description]-[suffix]***

| Component | Description | Required? | Constraints |
|-|-|-|-|
| **`prefix`** | Henkel Business Units | ✔ | len 3, fixed |
| **`location`** | Resource Location | ✔ | len 4-10, a-z0-9 |
| **`environment`** | Environment | ✔ | len 3, a-z, enum |
| **`project`** | Project/Product/App Name | ✔ | len 1-20, a-z, enum |
| **`resource`** | Resource Type | ✔ | len 1-3, a-z0-9 |
| **`description`** | Additional Description | ✗ | len 1-20, a-z0-9 |
| **`suffix`** | Resource's instance number or random number as applicable | ✔ | len 4, a-z0-9 |

The following are the possible values under each component:

##### Prefix

This is a value prefix used for all resources. Typically this is abbreviation for [henkel's business units - see table above](./naming-conventions.md#henkel-business-units)

##### Location

Location is required when there’s a possibility to create a given resource in different locations.

- **Regional** - five letter acronym (two letters for the continent, two for cardinal directions, 1 digit)
- **Zonal** - six letters - Regional + zone
- **Global** - `g`
- **Multi- and Dual-regional** - follow GCP’s own naming (two letters for multi and 4 letters for dual-regional)

| Location  | Short Name |
|- |- |
| Europe-west1 region  | euwe1  |
| Northamerica-northeast1 region  | nane1  |
| Europe-west1 region, zone a  | euwe1a  |
| Europe multi-region  | eu  |
| Europe-north1 and europe-west4 dual-region  | eur4  |

##### Environment

Resources belong to deployment environments.

| Environments  | Short Name (3 letter)  |
|- |- |
| Development  | dev  |
| uat  | uat  |
| production  | prd  |
| Internal  | int  |

##### Project

This is different from a GCP Project. Typically one Project will have multiple GCP Projects. We will use flat hierarchy and Project serves as the main mechanism of organizing resources into groups.
This could be name of the Project or Product or Applicationor Workload.

| Application/workload  | Short Name (upto 10 letters, keep it short and meaningful)  |
|- |- |
| e.g. SomartSmart  | ssmart  |
| e.g. Video Analytics  | vanalytics  |
| e.g. Private DNS  | pvtdns  |
| e.g. Covid Demand Tracker  | coviddtrack  |

##### Resource

 Abbreviation of the given resource type. three letters.

| Resources    | Short Name  |
|- |- |
| Networking  |   |
| VPC Network  | vpc  |
| Subnet  | snt  |
| Compute & Web  |   |
| Compute Engine VM Instance  | cin  |
| Compute Engine VM Instance Group  | cig  |
| Kubernetes Engine Cluster  | kcl  |
| Databases  |   |
| BigQuery Dataset  | bqd  |
| Storage  |   |

##### Additional Description

A description used to distinguish between resources of the same type but different roles. For example a group of servers with a different purpose - `frontend` and `backend`. This should not be used to differentiate between multiple instances of the same purpose resource, use `suffix` instead.

It’s also beneficial to agree on generic keywords used for description, when there is no better, more specific, term available. This avoids many different names like `main`, `core`, `common`, `this` and similar.

- `frontend`
- `backend`
- `cache`
- `database`

##### Suffix

Typically respective resource's running instance count. If you launch 2 Compute engine VM instances
first instance's suffix would be 01 and second's 02
**Note -** For GCP projects suffix should be a unique random string as its always better to have some kind of uniqueness for project names/IDs. Random suffixes can be easily generated with Terraform random_id resource.

Example:

- `a49f`

#### Examples

**e.g. 1.  c-euwe1a-prd-coviddtrac-cin-01**

- c – Henkel Consumer Brands business Units
- euwe1a- Europe west1 region, zone a  
- prd – Production Environment
- cvdtrck – Covide Demand Tracker (Product name)
- cin – Google Compute Engine VM Instance
- 01- Instance number

**e.g. 2.   s-eu-int-pvtdns-kcl-01**

- s - Shared (It is a shared service that can be consumed by other Henkel projects)
- eu - Europe multi-region
- int - Internal (It is an internal project)
- kcl  - Google Kubernetes Engine Cluster
- 01 - instance number

### GCP Folders & Projects

#### Folders

To further structure resources, consider adding an additional component to naming pattern, such as `[org_group]`. Folders can then follow `[prefix]-[org-group]` pattern.

<<PENDING>>

#### Projects

Projects (and Folders) are considered resource containers for the purpose of this naming convention and therefore we can omit the `resource` part of the name.

Notice that GCP does this by default for projects created via console - e.g. `qwiklabs-gcp-02-652b346f9c3b`.

Project IDs in GCP have to be globally unique and cannot be deleted immediately. This is kind of bad news for automation, as you can’t create a project with the same name right after it has been deleted. And that’s why we propose to include the unique random suffix part.

GCP also allows configuring Project Name. We recommend to set this to the same value as Project ID and forget about it. For all the practical purposes we’ll reference the Projects by their IDs.

GCP Projects will therefore be named following the `[prefix]-[project]-[env]-[suffix]` pattern.

- `l-coviddtrac-prd-a8d6`
- `s-pvtdns-int-ab45`

### Service Accounts

Service accounts should follow the `svc-[resource]-[description]` pattern only, as the project name already gets included by deault in the part after `@` and therefore there’s no need to repeat it.

- `svc-cin-frontend@l-coviddtrac-prd-a8d6.iam.gserviceaccount.com`

### IAM and Groups

PENDING. Need to establish a naming convention for groups and a strategy on how to assign permissions. As a rule of thumb, we should never assign permissions directly to individuals, but to groups only.

### Labelling Resources (Labels aka Tags)

 Use of labels (or tags) helps to add information to further categorize resources, such as `cost-center`. Labels are also helpful in situations when you can’t manage resource names directly, but you can manage a set of labels that is propagated to the child resources (e.g. GKE Cluster labels or Instance Groups).

Do not duplicate information already contained in your naming convention (such as `project`) or create large numbers of unique labels with information that can be obtained from the objects themselves (such as `creationTimestamp`).

**Labels for cost allocation**

Typically, use business labels such as cost center, business unit, or project to
associate  costs with traditional financial reporting dimensions within the organization.

**Labels for automation**

Resource or service-specific labels are often used to filter resources during infrastructure
automation activities. Labels can be used to opt into or out of automated tasks, or to identify
specific versions of resources to archive, update, or delete. For example, if you run
automated start/stop scripts that turn off development environments during non-business
hours to reduce costs. In this scenario, VM instance labels are a simple way to identify the specific development instances to opt into or out of this process

**Labels for operational support**

Labels can be used to integrate support for cloud resources into day-to-day operations including
IT Service Management (ITSM) processes such as Incident Management. For example, Level 1
support teams could use labels to direct workflow and perform business service mapping as part
of the triage process when a monitoring system triggers an alarm. Also it is very common to use
labels to support processes such as backup/restore and operating system patching etc.

**Labels for access control**

Identity and Access Management (IAM) policies support label-based conditions, enabling
 to constrain permissions based on specific labels and their values. For example, IAM
user or role permissions can include conditions to limit access to specific environments (for
example, development, test, or production) or Virtual Private Cloud (VPC)
networks based on their labels.

**Labels for security risk management**

Labels can be assigned to indetify resources that require hightened security risk management practices such as VM instance hosting application that processes sensitive or confidential data (e.g. PII, PCI). This can enable automated compliance checks to ensure that proper access controls are in place, patch compliance is upto date, & so on.

Should include below mandatory labels to tag resources while provisioning.

- name
- owner
- cost center
- classification

-

### Hostnames/DNS

Hostname/DNS naming convention needs to be alignment with existing Henkel Data center objects naming convention which is very well documented here - <https://confluence.henkelgroup.net/display/TAP/Naming+convention+for+Data+Center+objects>

This will help in great deal to teams to track & manage the resources inventory uniformaly across all DCs i.e. IBM/kyndryl DC, Private cloud (DigiLab & Public cloud (GCP in this case)

The recommended pattern to be followed while creating hostnames/DNS names for resources in GCP as follows:

1. VMs

    ***[location]-[resource]-[numbering]***

    Example#1 : Launch 1 Google compute engine (VM) belonging to Production environment in Europe-west1 zone a
        **euwe1a-vi-100001**.henkelgroup.net

    Example#2 : Launch 2 Google compute engine (VM) belonging to Test and Development environments in Europe-west1 zone a and Europe-west1 zone b
        **euwe1a-vi-300001**.henkelgroup.net
        **euwe1b-vi-500001**.henkelgroup.net

2. LoadBalancer

    ***[location]-[resource]-[purpose]-[numbering]***

    Example#1 : Launch an internal LB instance belonging to Production environment in Europe-west1 zone a. This LB is going to sit on top of nginx web server.
        **euwe1a-lb-m-11001**.henkelgroup.net

    Example#2 : Launch an external public facing LB instance belonging to Development environment in Europe-west1 zone b. This LB is going to sit on top of Apache Tomcat application server.
        **euwe1b-lb-n-95001**.henkelgroup.net

3. DB Instance

    ***[mainidentifier]-db-[dbengine]***

    Example#1 : Launch MSSQL DB instance belonging to Covide demand tracker project.

    **coviddtrack-db-mssql**.henkelgroup.net

    Example#2 : Launch Oracle DB instance belonging to SomartSmart project.

    **ssmart-db-ora**.henkelgroup.net

| Component | Description | Required? | Constraints |
|-|-|-|-|
| **`location`** | Resource Location | ✔ | len 4-10, a-z0-9 |
| **`resource`** | Resource Type | ✔ | len 1-3, a-z |
| **`numbering`** | NNNNN Numbering scheme | ✔ | len 1-5, a-z0-9 |
| **`purpose`** | Purpose usually used after SV/LB types | ✔ | len 1, a-z |
| **`dbengine`** | DB Engine type. Applies to DBs | ✔ | len 1-10, a-z |
| **`mainidentifier`** | DB indetifier. Applies to DBs | ✔ | len 1-20, a-z0-9 |

The following are the possible values under each component:

##### Location

Location is required when there’s a possibility to create a given resource in different locations.

- **Regional** - five letter acronym (two letters for the continent, two for cardinal directions, 1 digit)
- **Zonal** - six letters - Regional + zone
- **Global** - `g`
- **Multi- and Dual-regional** - follow GCP’s own naming (two letters for multi and 4 letters for dual-regional)

| Location  | Short Name |
|- |- |
| Europe-west1 region  | euwe1  |
| Northamerica-northeast1 region  | nane1  |
| Europe-west1 region, zone a  | euwe1a  |
| Europe multi-region  | eu  |
| Europe-north1 and europe-west4 dual-region  | eur4  |

##### Resource

 Abbreviation of the given resource type. three letters.

| Resources    | Code (2 letters)  |
|- |- |
| Server (Physical/bare metal)  | sv  |
| Workstation or Client Computer  | ws  |
| Cluster IP  | cl  |
| Load Balancer | lb  |
| Virtual Instance (VMs)  | vi  |

##### Numbering

**General Numbering Scheme**

- Applicable to Server/Physical/bare metal, Workstation or Client Computer and VMs
- NNNNN Numbering scheme: Sequential Number, 5-digits, filled with leading zeroes.

**N1** : The first digit **N**NNNN conveys a classification concerning environment type.

| Environments  | Code (1 digit)  |
|- |- |
| Production  | 1  |
| Test / Quality Assurance / UAT | 3  |
| Development  | 5  |
| Sandbox / Proof of Concept / temporary purpose  | 7  |
| Golden Master / Template System  | 9  |

**N2-N5** : The remaining 4 digits N**NNNN** have no special meaning. Typically respective resource's running instance count. for example If you launch 2 Compute engine VM instances first instance's **N2-N5** would be 0001 and second's 0002.

**E.g. 1** If you launch Compute engine VM instance belonging to Production environment then numbering component for respective VM instance would be - 10001

**E.g. 2** If you launch 2 Bare metal server instances belonging to Test environment then numbering component for respective Bare metal server instances would be - 30001 & 30002 respectively.

**Load Balancer Numbering Scheme**

- Applicable to Load balancers
- NNNNN Numbering scheme: Sequential Number, 5-digits, filled with leading zeroes.

**N1** : The first digit **N**NNNN conveys a classification concerning the network zone.

| Network Zone  | Code (1 digit)  |
|- |- |
| Intranet/Internal  | 1  |
| Inner-DMZ | 8 |
| Outer-DMZ/External  | 9  |

**N2** : The second digit N**N**NNN conveys the environment type.

| Environments  | Code (1 digit)  |
|- |- |
| Production  | 1  |
| Test / Quality Assurance / UAT | 3  |
| Development  | 5  |
| Sandbox / Proof of Concept / temporary purpose  | 7  |
| Golden Master / Template System  | 9  |

**N3-N5** : The remaining 3 digits NN**NNN** have no special meaning. Typically respective resource's running instance count. for example If you launch an internal LB instance then **N3-N5** would be 001.

**E.g. 1** If you launch an internal LB instance belonging to Production environment then numbering component for respective LB instance would be - 11001

**E.g. 2** If you launch an external LB instance belonging to Test environment then numbering component for respective LB instance would be - 93001.

##### Purpose

 Purpose is usually used after SV/VI/LB types

| Purpose    | Code (1 letter)  | Example |
|- |- |- |
| Middleware System  | m  | webservers, DB Server, etc. |
| Non-SAP resp. does not fit into other class  | n | application servers |
| Infrastructure   | i  | VMWare ESX hosts, Storage System, etc. |
| Business Intelligence aka. “BI”   | b  | |
| SAP System component | s  | SAP SCS, AS (ABAP + Java), DB, etc. |
| Utility Services   | u  | Terminal Services / Citrix, ADFS Service, SMTP, Reverse Proxies, etc. |
| Domino   | d  | |
| Robotics or other human-simulating agents   | r  | |

##### DB Engine

 Database engine being used for DB instance.

| DB Engine    | Code (1-20 letters)  |
|- |- |
| Oracle  | ora  |
| MSSQL  | mssql |  
| MySQL  | mysql  |
| MariaDB  | maria  |
| PostgreSQL | pgsql  |
| MongoDB   | mongo  |

##### Main Indetifier

Typically name of the Project (Not GCP Project) or Product or Application or Workload.

| Application/workload  | Short Name (upto 10 letters, keep it short and meaningful)  |
|- |- |
| e.g. SomartSmart  | ssmart  |
| e.g. Video Analytics  | vanalytics  |
| e.g. Private DNS  | pvtdns  |
| e.g. Covid Demand Tracker  | coviddtrack  |

### Exceptions

There will always be exceptions where it’s not possible to follow the Global Naming Pattern (for example resource does not allow `-` in the name) or when it simply doesn’t make sense. A subset of the full pattern should be used if possible and all exceptions documented.

### References

1. GCP - Creating and Managing Projects: [https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying\_projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects)
2. GCP - Best practices for enterprise organizations: [https://cloud.google.com/docs/enterprise/best-practices-for-enterprise-organizations](https://cloud.google.com/docs/enterprise/best-practices-for-enterprise-organizations)
3. GCE API - REST reference: [https://cloud.google.com/compute/docs/reference/rest/v1/](https://cloud.google.com/compute/docs/reference/rest/v1/)
4. GKE API - REST reference: [https://cloud.google.com/kubernetes-engine/docs/reference/rest/](https://cloud.google.com/kubernetes-engine/docs/reference/rest/)
5. GKE - Creating and managing labels: [https://cloud.google.com/kubernetes-engine/docs/how-to/creating-managing-labels](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-managing-labels)
6. HENKEL Naming convention for Data Center objects: [https://confluence.henkelgroup.net/display/TAP/Naming+convention+for+Data+Center+objects](https://confluence.henkelgroup.net/display/TAP/Naming+convention+for+Data+Center+objects)
