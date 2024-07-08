# Google Cloud Platform at Henkel

Within the Hybrid Cloud Program, Henkel signed a partnership with Google dating back to 2021. THis provided us access to our second public cloud provider to deploy cloud solutions into. Google helps Henkel to get access to their innovative technology portfolio and was selected as thought leader on automation and SRE principles, but also the culture under which Google works. Henkel's Cloud Architecture Team manages the Google Cloud Platform Landing Zone as our new **primary** Public Cloud Platform. In return, *Henkel Managed Cloud* can leverage more options for all use cases, depending on your application operating model.

!!! warning
    At the moment, Henkel Cloud Team expects you to bring in the necessary skills to operate the entire stack. We provide support only for the landing zone parts, however will advice you on the implementation on best effort. We **cannot** take over any production support until the Operations team at Henkel dx is in full swing, especially for Compute Engines. If you require a higher SLA and maintenance (required by CSIS), please discuss this with the Cloud Team beforehand.

The service model of GCP@Henkel is **different** than e.g. Azure@Henkel and will become the leading cloud service model we follow. It is the base foundation for all workloads that are placed on Google Cloud. It currently has following capabilities:

- Global Organization Concept, that divides workloads into host and service projects.
- Consolidated Billing Accounts for central billing and cost distribution to Henkel dx cost centers.
- Dedicated network connectivity into other Henkel system realized via a multi hub-spoke system and Partner Interconnect
- Global private DNS services and additional SSL certificate support
- Security and Organizational policies that manage the overall and default security of GCP projects
- Separate service accounts per project
- Deployment of a project account for a team / solution / application

## Account Concept

- The entire project is deployed using infrastructure as code and as such, governed and changed using this only.
- Platform and workload infrastructure are separated.
- Billing is be attached to Henkel.
- Development, Test and Production stages must always be separated.
- For each project, an Azure AD Group is mandatory.
- There are shared folders and projects for central services.
- Each Project obtain a standard service account, which has enough permissions to use infrastructure as code and deploy resources into
- Workload Identity Federation is activated to allow external tools (Azure Pipeline to) deploy into the account temporarily assuming above service account using STS

!!! Info
    Project accounts are created fully automated by the Cloud Platform team. Everything is written in code. We highly encourage teams to also deploy services only based on Terraform. Follow [this link](https://cloud.google.com/recommender/docs/tutorial-iac) to learn about GCP's take on it.

## Region concept

Three regions are available and connected via [Partner Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/partner-overview) to the Henkel WAN. 

- EIMEA: europe-west3 (Frankfurt)
- Americas: us-east4 (N. Virginia) 
- APAC: asia-southeast1 (Singapore)

## Security details

- Only a set of certain Virtual Machine types will be officially supported. At the moment, theses are:
  - Debian and derivates i.e. Ubuntu
  - Rocky Linux, RedHat Linux, CentOS Stream and Alpine
  - Windows Server 2019
- All machines **must** have the [OS config agent](https://cloud.google.com/compute/docs/manage-os#agent-install), endpoint protection (Falcon Sensor)  being installed and patching must be activated. Please reach out to Cloud Security and Cloud Operations teams.

### IAM

- GCP Projects can only be accessed using Henkel's Azure AD tenant and federation into GCP Cloud Identity.
- Externals MUST use Pulse VPN and raise an ESA request to authenticate with their henkel user and a henkel.com UPN
- AAD roles are mapped against GCP groups and managed by Cloud LZ team.
- Service accounts can be used for programmatic access, for example infrastructure as code deployments and CI/CD actions.

### Networking details

- There are shared VPCs on which a workload can connecte to. VPCs and firewall rules are not managed by the project.
- Workloads can either be DMZ or non-DMZ
- By default, egress internet must traverse the ZScaler Proxies to communicate to thge outbound internet. This allows Henkel to perform traffic aNd package inspection
- By default, all *direct* services egress to the internet is not possible (no NAT device allowed), but a Henkel proxy to be used.
- For further access to GCP services, the initiator must traverse via **Private Service Connect** for Google APIs

### Image Factory

- An image factory for VM images and container images will be introduced later. It will replace standard images and disallow fetching docker containers from Docker Hub and allow central image and container scanning. Use Artifact Registry to store decentrally your Docker images, which allows you to scan the containers as well.


More details on the Landing Zone page.