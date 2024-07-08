# Cloud Landing Zone Governance

Agreement between a Cloud User and the Cloud Platform.

This Governance is defined for users leveraging the Cloud platform through a cloud Landing Zone. Landing Zones  are an generic container for Cloud based applications at Henkel. The Platform is delivered by the dxV Tower, served to all kinds of Henkel functions as general purpose of the Cloud Service Providers (CSP), Google Cloud, Microsoft Azure. 

The detailed agreements between the platform and the user are confirmed individually per CSP and the CSP Service. Therefor please consider the pre-read pages as cross-reference to this landing Zone governance.

## Roles 

Roles addressed in this govervance document and [cloud docs](../cloud/getting-started.md) are mainly refered to "the user" or "owner". With the below we want to define what are these in the context of Henkel IT. 

Roles can have synonymes used in this documentation as follows.

### User

The Asset owner as per the [CSIS](https://CSIS/) Standard

Synonyms:

- Asset Owner
- Subcription Owner
- Product manager
- Application manager
- Tenant user
### Platform

The operator of the Henkel engineered Cloud Platform that is dxV Global Infrastructure reposnsible for.


Synonymes

- Platform Operation
- Platform Team
- Cloud Team
- Cloud  CoE 

## Pre-Read
We strongly recommend to pre-read following sections to get an better understanding about the Cloud Service Model and the cloud platforms itself in the given order

1. [Platform Serivce Model](../cloud/azure/az-service-model.md)
1. [Azure platform Intro](../cloud/azure/platform-guide/platform-guide-intro.md)
1. [GCP Intro](../cloud/gcp/index.md)
1. [Cloud Adoption](../cloud/azure/adoption.md)
1. [Azure landing Zone](../cloud/azure/platform-guide/platform-guide-landing-zone.md)
1. [GCP Landing Zone](../cloud/gcp/landing-zone.md)

## Motivation & Scope

We believe that effective Cloud Governance is the key to success.
Cloud workloads in Henkel span either Public Cloud or Hybrid Cloud model. Having a proper Cloud Governance structure may help project teams to be adhered with the Henkel defined best practices and standards that in turn helps us reducing the Risk and be comply with our standards.
The Governance Policies, definitions, standards and best practices that, set by Henkel Corporate Cloud Architecture Team (dxV) in this document is in line with the respective stakeholders such as Network, Security, Firewall and DevOps Teams
The scope of Governance Policies, definitions, standards and best practices that state in this document are,

a) applicable to Henkel Public Cloud landscapes that are not limited to existing Henkel subscriptions or Accounts of Microsoft Azure, Amazon Web Services, Google Cloud Platform and Alibaba but this may applicable to any Public cloud platforms that Henkel currently possess or may add to the portfolio in the future, and such Cloud platform(s) may generally termed as HMC (Henkel Managed Cloud)

b) to be duly considered by Cloud Governance, Cloud Security, Network Teams, Architecture work groups and Management teams of Henkel to measure the and certify or approve each of the workloads on Cloud

c) not to be shared directly with the vendors

Should you require further clarity on any of the topics in this documents, you may contact cloud@henkel.com

## Cloud Governance Pillars

Henkel Managed Cloud Platform complies with the following Governance Pillars and that Henkel Corporate Cloud Architecture team mandates each Cloud projects to build the Cloud environments in accordance with this.

- Security
- Identity
- Agility
- Consistency
- Cost

## SECURITY

### Introduction and Security Principles  

The purpose of this chapter is to define fundamental and general governance, compliance, and security requirements covering cloud hosting with third-party cloud service providers and their associated services.
As a general principle all cloud applications and systems must implement at least the same security and compliance levels as systems and applications hosted on-premises
– the Henkel Corporate Standard Information and Cyber Security (CSIS) always applies.
Ultimately, Henkel is accountable for the security and privacy of all Henkel information, even when contained within public cloud environments and/or when public cloud services are being operated by the CSP or other third parties.

Therefore, the following general rules apply:

1. All processing, storage, and geographic location of Henkel information must comply with local state or territory legislation and regulation (e.g. but not limited to GDPR, Schrems II, etc)
2. Henkel follows a managed cloud approach including standardized architecture/security patterns. Any cloud solution demands that are outside of pre-approved designs, patterns, or automated guardrails
must be assessed and approved by Henkel’s cloud team (cloud@henkel.com) to confirm that privacy and security requirements for the solution have been met and acceptable risk levels are maintained.
3. A defense-in-depth approach is mandatory, protecting Henkel data at multiple layers simultaneously (e.g. network, compute, storage, application etc)
4. Unmanaged sand box environments must not contain Henkel data or Henkel branding and they must not be connected to Henkel networks
5. Utilization of the cloud provider’s native tools and managed services must be preferred over self-developed solutions if they comply with the requirements set forth in this document and the CSIS
6. Utilization of automation must be preferred over manual processes and activities
7. The application of settings and configurations via infrastructure as code must be preferred over manual application. However, secrets, keys, passwords etc. must not be stored in code or any other file type

### Identity and Access Management

A well-designed identity and access management (IAM) is probably the single most important and effective security measure in modern cloud environments.
Virtually all actions and accesses are governed by the rights granted to users, groups, and roles via the cloud service providers’ identity and access management systems. See CSIS chapter 5 for fundamental corporate rules.

The security requirements for cloud IAM are:

1. A  Henkel centralized identity solution (e.g. Azure AD) must be used for all identities used within cloud services

2. Access to cloud environments must be managed centrally with logical groups in myID

3. A role-based access model must be in place to limit access to / use of data and systems to a minimum level required for business or IT operations (need-to-know-principle and least-privilege-principle). This model must be reviewed yearly.

4. Multi-factor authentication or certificate-based authentication must be used for all personal accounts used to manage and administer cloud services. Automation facilitated by special service accounts that do not support above mentioned methods must comply with Henkel password policy

5. Privileged administrative access must only be granted restrictively on a need-to-know and least-privilege base. The granted privileges must be reviewed every 6 months.

The platform delivers best practice access concepts as follows

Identitity and Access managemnt behavior of the Platform is described in detail in the [Azure Cloud Platform Access Control](https://henkelgroup.sharepoint.com/:b:/r/teams/MST-F-CloudCenterTheOfficialSite/Shared%20Documents/General/Azure%20Platform%20Access%20Control%20Concept%20v.1.0.pdf?csf=1&web=1&e=NgPpXC). For <google please find details under [Google Landing Zone](./gcp/landing-zone.md).

### Data Security

Before data is processed, stored or transmitted within a cloud environment, the data owner or data custodian must identify all relevant legislative, contractual, and compliance requirements and subsequently make sure that the necessary security controls are in place. The protection of data is important to prohibit unauthorized persons from accessing sensitive information. In this document we refer to “data at rest” for data stored in persistent storage and to “data in transit” for data which is being transferred from one location to another including message busses or queues. See CSIS, chapters 5, 6 and 9 for the fundamental corporate rules.

The following requirements can apply:

1. Access to data must be governed by the least privilege principle, restricting access as much as possible

2. Access to cloud storage must utilize encrypted protocols
3. Anonymous public access to cloud storage must not be enabled by default
4. Private endpoints or links for cloud storage must be considered in the design stage and justification must be provided if not utilized  
5. Network-based cloud storage access control (e.g Azure Storage Firewall) must be considered in the design stage and justification must be provided if not utilized
6. Data in transit must and data at rest should be encrypted with state-of-the-art encryption algorithms using secure settings (e.g. at least TLS 1.2). Please refer to the Henkel Crypto Policy for details
7. The cloud service provider’s native encryption should be used. Alternatively, implementations of encryption algorithms from standard libraries must be used. Self-developed crypto libraries must not be used
8. Key management tools and processes must be used. CSP provided tools and mechanisms must take precedence over customer managed approaches if applicable. If a customer-managed approach is chosen, the key management process must be documented and reviewed. In both cases, a role-based access model for key creation, usage, rotation, and deletion must be created
9. Each key must only be used for a single purpose. The key size must have an appropriate key length and cipher algorithm. Use at least RSA 4096 bit keys, recommendation is ECDSA ciphers.

### Infrastructure Protection

In this chapter we describe the general security requirements for cloud compute and cloud network resources. Both are extensively configurable and therefore offer lots of security pitfalls and security optimizations. Please note that the security requirements and best practices for containerized deployments (e.g. Azure Kubernetes Service (AKS)) will be put forward in separate documents. See CSIS chapters 6, 8, 9 for fundamental corporate rules - the following minimum requirements apply>

- [GCP](../security/infrastructure/gcp.md)
- [Azure](../security/infrastructure/azure.md) 

#### Networks

1. The cloud network design must adhere to the Henkel cloud network model described in [Azure Network](../cloud/azure/platform-guide/azure-network.md), [GCP Network](./gcp/gcp-networking.md) document  
2. Access to Henkel resources on-premises must only be facilitated via the central (VPN) connection between Henkel and the CSP
3. Cloud networks must be segmented and traffic between the segments must be restricted using CSP provided filter mechanisms.  The restrictions should limit the allowed traffic based on the need-to-do principle
4. Services exposing otherwise unsecured http-based interfaces to the Internet must be protected by a web application firewall configured to defend against common variations of attacks described in the OWASP Top 10
5. Production environments must be segregated from non-production environments on a network or logical level

#### Compute

1. All compute instances must be hardened to minimize the attack surface by removing all unnecessary functionality. Industry best-practice standards for hardening must be used such as CIS benchmarks (level 1 requirements)
2. Multiple, automated compute deployments must use approved and tested OS images only from trusted repositories. OS images provided by the CSPs are considered safe – hardening requirements still apply
3. Compute instances must be covered by the Henkel dx vulnerability management
4. All compute instances must be covered by a patch management process addressing all layers (OS, middleware, and application) which needs to be documented before entering production
5. Compute instances running MS Windows must be protected by anti-malware technology

### Application Security  

The vast majority of vulnerabilities today can be linked to flawed code. This is not limited to applications being developed in or for the cloud but also pertains to the process of provisioning and managing of cloud resources by scripts and configuration files (Infrastructure as Code). In the following, a general set of requirements is put forth to address this challenge - see CSIS chapter 10 for the fundamental corporate rules.

Secure Code, Pre- and Post-Deployment Security Requirements:

1. Developers must adhere to best-practice software security coding practices. The goal is to ensure the availability, integrity and confidentiality of data and resources at all times. The OWASP Secure Coding Practices can serve as a good foundation (Link)
2. The application must be checked with static and dynamic application security testing tools provided by dx. SAST checks must be carried out on every build pipeline run on the master branch
3. Infrastructure as Code scripts and templates must be checked with a static code analysis tool for IaC to identify security flaws
4. A code dependency check to identify publicly disclosed vulnerabilities in the project's dependencies must be carried out using WhiteSource provided by dx
5. If container technology is deployed the container scanning solution provided by dx has to be incorporated into the build pipeline and regular scans against the image repository have to be scheduled  

### Detection

An important part of a holistic security concept is the implementation of detection mechanisms to be able to react early and accordingly. All public cloud providers offer centralized security management tools and/or portals, often called Security Centers (e.g. Azure) or Security Hubs (e.g. AWS) that can play a vital role in detecting and remediating security problems. Furthermore, all cloud providers generate and offer access to various kinds of logging information like activity and flow logs. Henkel seeks to aggregate these logs into a central log management solution to have an overview of logs from different sources.
In this section we define requirements on how to configure and use the cloud providers’ security centers, their activity logs, and Henkel’s log management solution (see CSIS chapter 12 for fundamental corporate rules)

1. The CSP security centers or hubs must be activated and applied to all resources  
2. The security centers/hubs are being configured and operated according to best practices for each resource type as defined by Henkel dx or, if these are missing, according to CSP recommendations
3. A logging concept for the recording, protecting, and monitoring of user and administrative activities, information security events, and system faults for high-risk information assets must be created and maintained. The information asset owner should use the template for a logging concept at <http://csis>
4. All CSP environments must be enabled to ship security logs and event information to Henkel’s central log management solution
5. Application/service owners must contact the dx Security Operations Center to assess whether their log data should be incorporated into the central log management solution and provide access to this data subsequently
6. Responsibility must be assigned to continuously monitor, assess and evaluate all findings and recommendations from the CSP security centers or hubs, and to fix the relevant ones (i.e. true positive) in a timely manner (i.e. the most risky ones first and urgently)

## IDENTITY

### 2.1. Secure Identity & Principle of least privilege

The principle means giving a user account or process only those privileges which are essential to perform its intended function. Henkel uses Azure Active Directory, Microsoft's enterprise cloud-based identity and access management (IAM) solution which is also the backbone of O365, that in sync with on-premise Active Directory as the corporate Identity and Access Management solution

### 2.2. MFA (Multi Factor Authentication) for Administrators

Accounts that are assigned administrative rights are targeted by attackers. Requiring multi-factor authentication (MFA) on those accounts is an easy way to reduce the risk of those accounts being compromised.

What-to-be-done:

MFA to be enabled for the users belongs to the following AAD roles (Azure specific)

- Authentication Administrator
- Billing administrator
- Conditional Access administrator
- Exchange administrator
- Global administrator
- Helpdesk administrator
- Password administrator
- Privileged Role Administrator
- Security administrator
- SharePoint administrator
- User administrator

### 2.3. Azure PIM or similar CSP technique for privileged Access Management

Use PIM or Just-In-Time (JIT) access controls to provide time bound privileged access via Azure AD by setting start and end dates and following configurations on PIM to be ensured. The cloud platform offers PIM or tempoaray access solutions on a generic level

#### What-to-be-done

- Configure to trigger approval to activate privileged roles
- Enforce Azure AD multifactor authentication to activate any role
- Configure to trigger notifications when privileged roles are activated
- Conduct access reviews to ensure that users still need roles

### 2.4. Assign Roles to Groups, not to Users

It is insecure to assign roles directly on Users as it may leave potential security pit fall. Safer and maintainable option is to place users into logical groups.

!!!info What-to-be-done

     The required logical groups to be created for the respective project roles at Henkel myid and add users into it – the respective groups will be created in the respective Cloud providers that to be attached to the various services.

### 2.5. Log and Alert on Changes to Administrative Group Membership

All the activities and Incidents with various severity levels on Henkel Managed Cloud Platform to be notified to the platform administrators or the respective Incident Management desk

\* The function and activities of Incident Management desk/group to be defined

#### What-to-be-done

At minimum, the following activity logs to be enabled at Azure Active Directory and streamed to Henkel on-premise SIEM (Security Information and Event Management)

- Sign-ins - Information about sign-ins and how resources are used by users
- Audit - Information about sign-ins and how resources are used by users.
- Provisioning - Activities performed by the provisioning service

Current SIEM solution consists of  Apache Kafka, ELK and Splunk at on-premise Data Center that receives log streams from Azure.

Standard shipping to SIEM is handled by  the platform about infrastructure  indentity activities. 

### 2.6. Centralized access management & RBAC

There are mainly two types of Azure groups in scope

1. Azure Groups for administrators (Privileges Groups)
The accountability of creation and maintainability of these groups are with Henkel Active Directory Team or platform vendor should create/modify these groups only with the approval of Henkel Active Directory Team

2. Azure Groups for Projects/tenants

The required Azure Groups for the various projects to be finalized by the respective Platform implementation partners or vendors involved in projects followed by the review from Cloud Architecture Team. The responsible project role to contact the respective Henkel counter parts to create these logical groups in myid as access to myid is restricted only to Henkel employees.

#### What-to-be-done

Access to Henkel Managed Cloud to be managed centrally from logical groups in myid,  the creation of these groups to be created as part of project onboarding, myid in turn creates the respective Azure Groups via API

### 2.7. Cloud Native Governance Policies

The foundation for projects or tenant space delivers to project team only after ensuring that the required Policies are enforced and applied on  project tenant space, these policy enforcement ensures that the projects are following the Best Security principles and governance- here the project tenant space can be as following, that varies bases on the project size and cloud platform.

- Subscriptions and/or Resource Groups in Azure
- Organizations and/or Accounts in AWS
- Folders and/or Projects in Google Cloud

The list of enforced policies for tenant foundation are incorporated with the automation workflow for tenant foundation provisioning.
These policies are centrally managed and maintained by the platform provisioner and individual project team may not be able to alter these policies.
In case project teams has any use case(s) that needs alteration of any of these policies, that to be reviewed and approved by Cloud Architecture Team

## AGILITY

Henkel BizDevOps practice may help project team to reduce the number of check points and approvals before the project kick-off as it ensures better collaboration that in turn brings in Agility.
With this direction, Agility in Cloud Governance model is defined in a manner that none of the defined rules, guidelines and set standards pulls back projects from being Agile.

### Hybrid Cloud Portal

Henkel Managed Cloud spans across various Public and Private Cloud providers, that we collectively named as ´Hybrid Cloud´.

Hybrid Cloud Tenant (HCT) [Ordering Portal](./cloud-portal.md) acts as single tool to cater the following needs,

1. Requirement Gathering (for new Cloud workloads) or Assessment (for migrating existing workloads)
2. Placing order for Hybrid Cloud Tenant Space
3. Requesting Sandboxes for service evaluation purposes
4. Approval Space for the following
    - Security
    - Architecture
    - Inital finance

The in-built automation workflows in Hybrid Cloud Tenant (HCT) Ordering Portal help to reduce number of communication iterations between Project Teams and Cloud Architecture Teams hence contributing towards Agility.

### Automated Foundation Provisioning

Upon successful placement of Hybrid Cloud Tenant Request, the following tenant spaces get provisioned through automated and API driven workflows through Hybrid Cloud Tenant (HCT) Ordering Portal- these spaces would be customized based on the project requirement

### Infrastructure/Platform

This could be one of the following based on the project size and this is by enforcing the necessary Cloud native policies to ensure Security and Governance.

- Subscription or Resource Groups in Microsoft Azure
- Folders or Projects in Google Cloud
- Organization or Accounts in AWS

### DevOps

Azure DevOps projects with necessary rights and base Terraform templates are provided here. This space can be used by project team to build the project further by leveraging Centralized Terraform Module or Terraform Private Repo (TBD) and by incorporating with Azure Boards, Azure Pipelines and Azure Artifacts – the following deliverables are included,

- A new Azure DevOps project
- An attached Service Principal / Service Connection (to enable communication from Azure DevOps to the Platform)
- Separate Azure Repos for Dev (provided as blank) and Infra (provided with base Terraform template and Pipeline)

Please be refered to a sub section to this Model at [Henkel Devops](../devops/AdoGuideline/ado-guideline.md)

### Service Enablement

Services of the CSP must undergo an [Service Enabalment Process](../cloud/azure/sef/introduction.md) that is performed by the cloud platform in order to get activated in general.

Alternatively CSP services can be evaluated through [Sandboxes](../cloud/azure/platform-guide/platform-guide-sandbox.md) which are short living cloud environments, before going through an Service Enablment Process in cloud landing Zones. This process can take time depending on the complexity and exposure of the CSP service.

## CONSISTENCY

### Configuration Management

Configuration is kept in a code following GitOps practices that allow automation and resilient audit compatible re-conciliation of infrastructure changes.

The cloud platform offers controls for BiZDevOps Users that start with IaC and ending with configuraiton management solutions that are best of breed such as Ansible Automation and similar frameworks that are speficically on Container Frameworks.

See also
- [Henkel Devops](../devops/AdoGuideline/ado-guideline.md)
- [Azure Dev Guidance](./azure/dev-guide.md)
- [Terraform get started](../howto/getting-started-terraform.md)

### Infrastructure As Code (IaC)

 The use of IaC is strongly recommendted and must be applied in Production landing Zones if not otherwise agreed with the Platform. Guidance are given per CSP platforms (see [Adoption](../cloud/azure/adoption.md)). Other IaC frameworks than Terraform require exceptional handling as these are not supported and can lead into subseuqnt campatibility issues with the platform. Exceptions are perhaps required if mandatory features are not given in terraform but in CSP native IaC soltuions instead and at same time critical for the business.

!!!info Release

     By 2024 it becomes mandatory to integrate to Terraform Enterprise for re-usability and security reasons. Test roll-out is planned in Q3 2023. 


## COST

 Please review and familarise with the cost Governance section that explains how costs are governerd. See [Cost Governance](./cost-governance.md).

 - The user has the duty to plan, create and update the budget on its [Cloud Portal Ticket](https://cloudportal.henkelgroup.cloud) accordning to the assigned Landing Zone (Azure subscription, GCP Project).
 - The user agrees that budgets are udpated as soon as information is given or budget is about overrun on a monthly cadence
 - The users agrees that cost are managed
 - The correct clarity and EAM App-ID is assigned to the landing Zones
 - OS or on-premsise Database Licenses that have been procured are used within the CSP or have been assessed to be used within the CSP
 - Cloud resources are checked against the the possibility of pre-commited7 reserved capacity. Reservice capacity requests can be made via [Cloud Portal](https://cloudportal.henkelgroup.cloud) 
 - Regular Cost optimization using the CSP's advisors is performed on at leat a monthly candence
  

Cost Governance through pre-approval and monthly budget assessment control process flow.

![Alt text](../images/cost-governace.png)
