# Naming conventions




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


Detailed GCP resource naming convention guide is here - https://henkelgroup.sharepoint.com/:x:/r/teams/MST-C-HybridCloud/Shared%20Documents/General/200%20Public%20Cloud%20-%20GCP/Documentation/Henkel%20GCP%20Naming%20Conventions%20-%20v1.1.xlsx?d=wfb135c34283e482bbc393605b38fbc60&csf=1&web=1&e=0wq7gI

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
