# GCP Cloud Service Model

The Cloud platforms are developed and operated by the designated Platform Team which consists of Leading Architects, Cloud Engineers and Site-Reliability Engineers.

Support is described into three Adoption levels. This is to allow individual development to leverage the potential of the hyper-scalers and at the same time to offer a minium basis for control and security at enterprise scale.

Centrally provided operational support in regard to Landing Zone constituting components such as [Example here!!] is given via the platform team, see Adoption Level 1. Adoption Level 2 and 3 are complimentary enablement services.

Level 3 is typically leveraged by advanced BizDevOps Users which require high flexibility and operations support only in the context of centrally managed platform components.

Level 2, also called Cloud Adoption, is a transitioning scheme that gives users an opportunity to get cloud services partially or entirely into the adoption level 1 support. This can be beneficial to optimize run costs and allow operations at scale by the cloud platform team. Support at Level 2 is project support engagement between the requester and the Cloud Adoption team. Environments that are supported by Cloud Adoption are labeled as "BizDevOps Mainteance" and firmed under operations responsibility of the App Owner or Requester. This is due to clear liability and contract responsibilities when it comes to questions about security and operations governance. Cloud Adoption is no managed service.

![Alt text](../../images/service-mode-old-vs-new.png)

The Adoption level 2 is ordered at the [Adoption Project Support Team](../azure/adoption.md) that can be engaged over an [Cloud Portal Generic Ticket](../cloud-portal.md).

All support levels are related to the cloud infrastructure configuration and not related to middelware or application logic.

Below displayed, the options as an example timeline depicting three phases

![at](../../images/adoption-level-transitions.png)

## Overall platform and Service Structure

The schemes are descibed in three sections

1. Central Services: the Shared infrastructure services as well as the contract basis that is inherited by any application
2. Enablement:
   - Project- or Self-Service to create or to change existing cloud resources
   - You get T&M support by the [Cloud Adoption team](../azure/adoption.md) and get an opportunity to specify an infrastructure operations model that integrates to the platform operations where possible  
3. Application Infrastructure Operations
   - Landing Zone and a dedicated Virtual Private Network (VPC) is provided to contain the respective Application Infrastructure. The Landing Zone itself and the network is managed by the Platform team. A change to the configuration is provided as self-service through CI/CD in GitLab or AzureDevops
   - By default App Infrastructure within a Landing Zone is managed by the Platform Tenant User and reported as BizDevOps Maintenance
   - Only App infrastructure services that are ordered via an [Catalog item](../cloud-portal-catalogrequest.md) can be managed by the Platform Team. See commited detailes in the following sections.
  
![Alt text](../../images/adoption-service-model-details.png)

!!!info
    Cloud Adoption efforts are individual implementations on T&M basis to create or update App Infrastructure of a Landing Zone. The service is optional yet strongly recommended.

## Adoption Level 1

Following sections explain which operation support solutions and services are maintained centrally by the Platforms. Adoption Level 1 services are a minimum foundation to all higher Adoption Levels.

The mininum that is applied in Level 2 and Level 3 are services related to the platform and the Landing Zone including a Virtual Private Network. Optionally Level 1 service controls are applied on catalog items i.e. Cloud Resource.

!!! Info
    The catalog services are to be ordered via a [Catalog item](../cloud-portal-catalogrequest.md) if not othwerwise agreed. Other centrally managed guardrails and minimum requirements are documented in [Azure Service Enablement framework](sef/introduction.md) ## GCP Service Enablement Framework add?

### Level 1 Service contraints

#### Pre-requisites for Support at Level 1

- The services are ordered via [Catalog items](../cloud-portal-catalogrequest.md)
- Requester Team will focus on Application Development
- Requester Team will organize the Application Support
- Requester Team cannot change the cloud infrastructure independently. Process deviation shall be discussed upfront.

#### Pre-requisites to transition cloud resources from Level 2 to Level 1 are

- Services have been provisioned by [Cloud Adoption Team](../azure/adoption.md) over [Cloud Portal](../cloud-portal.md) order
- Efforts to standartize infrastructure operations towards Level 1 is intended and funded by the tenant user

#### Following limitations at Level 1 may occure

- Conflicting permissions do not permit to change the cloud resources independently from the Platform Team
- Cloud Resources are created or managed by the tenant user (BizDevOps Team) and deviate from standardized framework and guardrails.

!!! Warning
    In these cases it is possible that only shared platform services, for example VPC infrastructure is commited on SLA and Operations Support. Services that deviate from standardized setup, due to above mentioned, possible limitations, are under BizDevOps Maintenance

Title identifies the control or operations solution (identifies the resource level)

### Organization

**Scope: Platform**

The platform team manages cloud resources via policies and shared operations solutions such as an Azure Devops integration

In GCP policies are organized in a hierarchical resource schema- "Organization" as initial structural unit:

![Hierarchy](../images/../../images/gcp/RessourceHierarchy.png)

### Identity and Access Management

**Scope: Platform**

We secure the Landing Zones with best practice access technologies in conjunction with Henkel Access tooling. In order to establish access we follow automation. User can find further information in the [Landing Zone Goveranance](../cloud_governance.md) Identity Section:

Pleae find more information for this Service at [GCP Access Controls](../gcp/landing-zone.md)

### Vulnerability Management

**Scope: Platform/Landing Zone**

Vulnerability management mainly fouses on Container and Virtual Machine workloads. Provider managed Cloud Services are usually maintained centrally.

However the CSP issues Configuration Hardening guidelines to prevent customers from new vulnerbilities and recommends that Henkel applies selective configurations to mitigate security risks.

The Henkel Cloud Platform offers VM OS patch configurations that minimizes vulnerbilities. There is no platform guaranteed Vulnerbility Management beyond. All application related vulnerability scanning is in responsibility of the user. Utilizing Henkel Standard Tooling that the user can then further embeed into custom operation procedures, is envisioned.

- Google cloud offers the Security Command Center incorporated in the console
- On-demand access to Vulnerability Scanning via CrowdStrike [through dxS Cloud Security team] (mailto:mail-DL-dxS-CloudSecurity@group.henkel.com)

For virtual machines we apply scanning where possible and inform Cloud Users via Email about Vulnerbilities. These findings are typically issued by Henkel Cyber Security department. The pre-requisites that scanning can be applied by the cloud platform centrally varies per CSPs, Virtual Machine foundation.

Pre-requisites that the platform user need to confirm:

- The GCP OS Agents are installed into the OS and up-to-date
- Azure VM Guest configuration are installed into the OS

In addition the Platform team may be able to enforce vulnerability controls that monitor infrastructure vulnerbilities and remediates these on behalf of the user. The confirmation is either individually agreed via a [Cloud Portal Ticket](../cloud-portal.md) or the Platform informs on vulnerbilities types being prevented centrally.

!!! Info
    Vulnerbilities can be found on applications and middleware components that are not in scope of Cloud platform operations.

### Hardening Management

**Scope: Platform /Landing Zone /Cloud Resource**

The Cloud Platform offers hardend Virtual machines images which can be referenced in any deplyoment via infrastucture as code. Further details can be found [here](../gcp/landing-zone.md).

### Patch Management

**Scope: Platform/Landing Zone**

!!!Warning
    Under construction. Support is not yet fully activated. Roll-out is preparation.

For Patch management mainly Container and Virtual Machine workloads are in our focus.

OS Patching via Landing Zone:

!!! Platform team responsibility

- VM OS Patch Management is enforced centrally into your VM.
- Patch Templates are configured at GCP project level

!!! User responsibility
VM OS Patch schedule exception can be requested via the [Cloud Portal](../cloud-portal.md)

- Patch control creation on GCP Project
- VM OS Patch Job monitoring & job re-conciliation

### Cloud Cost Management

**Scope: Platform/Landing Zone**

Please refer to the designated [Cloud Governance Model](../cost-governance.md) for further information.

### Infrastructure Incident Management

**Scope: Platform**

For incident management please report incidents via Service Now. Typical response times are 24h. The Cloud Platform is no Henkel consumer or Business end-user platform. The platform is meant for BizDEVOPS, Development and Technical Operations Teams.

!!! Conditions before the platform team gets involved are:

- Approach happened over Service Health Desk, or other Infrastructure Support Teams e.g. GTT, DIS etc
- A first incident analysis has been initiated by the app team on the application and middleware ( e.g. application code)
- If the App is under BizDevOps maintenance, the user has to make an analysis on infrastructure level before escalating the Incident to the platforms

| Platform | Area | Group/ Email |  Comments  |
|-------------|----------------------|----------|--------|
| Azure | Platform  | Global.Appl.AzurePlatform.X | 24h response time.   |
| Google | Platform  | Global.Appl.GoogleCloudlatform.X | currently only hypercare agreements  |
| Private Cloud | Platform  |  | following  |

!!!Info
    Further detailed information follows soon, such as for P1/P2. Currently operations support and incident response times are estimated in the realm of 24h.

### Infrastructure Security and Alert Management

**Scope: Platform**

Security Alerts are reported to the Asset Owner and to the dxS Cyber Defense Team via Email. The dxS teams overlooks if the App owner becomes active or otherwise informs the Cloud Platform team via ServiceNow. The Cyber Defense or Platform Team can decide to take a service offline if no response by the App Team is documented. This activity is last resort and causes service interruption and/ or Business loss in the responsibility of the App owner.

!!! Info
    We recommend that the App Owners initiate a shared e-mail Box or Assignment Group via Cloud Portal.

### Change Management

**Scope: Platform**

Changes to the Cloud Platform or shared assets incl. Landing Zones can be requested based on an Incident, pull-request per [Azure Devops*](https://dev.azure.com/hmanagedcloud/AzurePlatform) or per Cloud Portal General Ticket type   ## Add picture?

!!! Info
    *Please approach us via Incident or Portal ticket, if no permissions to Azure DevOps are granted ( 403 or 404 Error depicted Azure DevOps Website)

### License Management

**Scope: Platform**

Licenses for Cloud Services, OS and Databases, can be gained by the CSP automatically (pay-as-you-go license) or potentially reused from on-premise. On-premise license transfer needs are to be analysed before project initiation. Please approach the dx license management team or[us](mailto:cloud@henkel.com)>.

### Monitoring and Alerting

**Scope: Platform/Landing Zone**

Henkels monitoring strategy involves the establishment of comprehensive monitoring solutions aimed at tracking the overall health, performance, and resource utilization of cloud infrastructure and services. A crucial aspect of this strategy is the configuration of alerting rules, which enables users to receive timely notifications when specific thresholds are exceeded or particular events occur within the cloud environment.

!!! Info
The platform team exlusively monitors activities, security, billing on **shared platform services**.

Further read:

- [GCP General Monitoring and Logging](../gcp/index.md)

!!! Info
    Please check with Cloud Adoption team or support to experience more about monitoring and logging.

### List of Network & Access Management Services

**Scope: Platform/Landing Zone**

We provide a list of network related Communication and Access solutions in correspondence with the Network and Security teams in dxV and DxS.

- Private Endpoint Support policies
- Network Access management through shared VPCs and Vnets
- Firewall Management through Gitlab and Azure Devops (powered by DxS Edge Security team)
- Henkel User Access via Zsclaer App connectors (powered by DxS Edge Security team)
- Henkel on-premeise access via GCP PartnerConnect and Azure ExpressRoute
- DNS Forwarder
- DNS automation for SSL Certificates and Domains

Find further information on the platform and landing zones topic [here](../gcp/index.md).

## Adoption Level 2

Adoption Level 2 environments are labeled as BizDevOps Maintenance and have following limitations re Platform Operation Services

- Best Effort advisory and Operations support with no SLA or response time other than agreed in the Cloud Portal Ticket
- Only Project related and agreed business hour response time [Cloud Adoption](../azure/adoption.md)
- SecOps + GRC’s are mainly done by BDO team

## Adoption Level 3

Adoption Level 3 environments are labeled as BizDevOps Maintenance and have following limitations re Platform Operation Services

- Best Effort advisory and Operations support with no SLA or response time
- Independently align your resource configuration with the central Landing Zone and Platform Services
- Independently handling Security updates
- SecOps + GRC’s are mainly done by BDO team

!!! Warning
    In this cases only the shared services such as network are commited on SLA and Operations Support.
