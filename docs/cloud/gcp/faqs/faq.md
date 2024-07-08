
## Frequently Asked Questions

## General questions

### Why did we introduce GCP? 

dx Global Infrastructure's goal is to enable dx teams in digital transformation projects by providing the best platform services and a certain degree of choice. To have an optimal mix of services, our own private cloud and two managed public cloud platforms are seen as key for this. Although basic services between hyperscalers are often very similar, Google is a big contributor towards open source technologies and leading in some areas such as Container Orchestration (Kubernetes, Anthos), Machine Learning (Tensorflow) and Analytics (BigQuery, Looker, Dataproc, BigTable).

### Which cloud should I choose when I start new?

The Henkel dx preference for public cloud is on **Google**. The landing zone for GCP is the most advanced and also offers very competitive conditions to us. For existing workloads, please reach out whether to go multicloud or move the workload out of other platforms. However, you need to bring in your own engineers and skilled staff to work on it, as we do not provide managed services currently and the account is under your full responsibility.

### Can I get more permissions?

The permissions we assign you are in line with the Henkel Security Standard and Cloud Architecture design. They are maintained and checked regularly by the Landing Zone team. If you need more permissions for a specific action, either the Cloud Archtecture team can perform them on your behalf or elaborate to change the authorization concept.

### I received a notice on Security Alerts. What shall I do?

**You are fully responsible for your Google Cloud Project.** If you deviate from the Landing Zone recommendations, this might cause a security finding. In any case, you must remediate the Security Findings from Google Security Command Center. Please reach out to your Cloud Security contact for questions.

### Why can't I use service keys in the service account?

It is best practice to disallow service keys, as reality shows they are rarely rotated and long-living. Instead, use the Google Workload Identity Federation to obtain an [STS token](https://cloud.google.com/iam/docs/reference/sts/rest). STS is trusted with Henkel's Microsoft Azure AD and allows you verify based on the caller's identity that actions on the platform are allowed. We provide sample code to obtain the `access_token`.

*STS is also used e.g. for Azure DevOps federation and terraform when impersonating service accounts.*

### How do I connect Azure DevOps/GitLab with GCP?

You need to use the OIDC auth token flow in conjunction with Google Secure Token Service and Workload Identity Federation feature, which allows you to get a temporary access token in exchange for the OIDC auth token. That token allows you to perform actions on behalf of a service account that has further permissions in your project. With that flow, we ensure no credentials are stored in pipelines and access if given in the time you need it (usually 1h). This is described in the [DevSecOps](./devsecops.md) section.

### Which services are available?

Currently we do not restrict any service on GCP. However, we will check the architectural design with you and guide you through services that are most suitable for your workload. Standard services we offer are **Compute Engine** (Virtual Machines), Cloud Run (PaaS runtime) and GKE (Kubernetes clusters).

### How do I obtain and request access to it?

Please raise a request via the [Cloud Portal](https://cloudportal.henkelgroup.cloud/). As known, you will need to take care of budget codes beforehand. Instructions to get onboarded are [here](https://docs.henkelgroup.cloud/cloud/cloud-portal/).

### How do you charge incurring costs?

Same as with all cloud services, Henkel pays them centrally (Corporate contract in Germany) and distributes costs to your IT products and implicitly to your cost center. Thus, we require the cost center and clarity codes to be accessible to us in Henkel dx. 
This means that your budget must be available within Henkel dx for intercharging. Thus, it is important to always keep Product/Clarity Code and Cost Center up to date. Let us know immediately when something has changed!

### How can I open support tickets?

You can open a support ticket on the top right of GCP. If you need special assistance, please also reach out to our Technical Account Manager.

### Can I onboard external partners?

For light access, you need to create a MyID Business Partner (i. e. Azure AD B2B Guest Identities), which creates an Azure AD guest identity. For heavy and frequent usage, a Henkel external user is recommended and needs in addition SSL-VPN (Pulse Secure). The company profile also needs allowlisting for the IP range (request via ServiceNow [catalog item](https://henkelprod.service-now.com/sp?id=sc_cat_item&sys_id=ae2f81191bc12d506965eb9f7b4bcbdc)). 
Usage of all identities except adresses ending with henkel.com is disabled on Google Cloud Identity as we cannot control incoming identities to the Henkel GCP Landing Zone.

### I cannot see my project. What do I have to do?

When you log onto GCP, go to the project picker on the top bar:

![](../../images/gcp-top-bar.png)

Then, select the henkel.com organization and then project under the folder

henkel.com > hmcp-landingzone-folder > hmcp-workloads > stages > your-project (or use the search bar)

![](../../images/gcp-project-picker.png)

### I need a larger subnet. What do I have to do? 

Subnets are provided at the beginning of a project and changing it later might be either impossible or require very difficult changes. So choose wisely your subnet size. We usually hand out /29 or /28 subnets, but larger ones depending on the amount of allocatable IPs are feasible. Just let the team know when requesting a project.

### How do I raise a firewall request? 

For the ZScaler network and perimeter firewall, you do this [via ServiceNow request](https://henkelprod.service-now.com/sp?id=sc_cat_item&sys_id=de24f2371b5355542542db58bb4bcbcd). This is part of the Edge Security process.

For firewalls inside Google Cloud Platform, the request needs to be described and will be worked on in the Project/Firewall factory. The Edge Security team will approve this. Firewall rules are applied in the host VPC and the containing subnet. 

### How do I define custom roles?

If your project know already which roles to use, we will create a gitlab project so you can describe your role as IAC and apply it to your project and the service acccounts. This give full transparency and maintainability for the app and infra operations team.

### How do I request a DNS entry on GCP?

We currently support `*.gcp.henkelgroup.io` for resolution. Those are maanged by landing zone team and in the network / hosts VPC projects.
This only works inside Henkel network, not on the internet (non-public DNS). To get a DNS entry, provide:

- the static IP of your load balancer
- the name of the DNS record
- the project

You will require a TLS certificate from PKI to have a workable FQDN. Henkel certificates are trusted. 

## Migration-related questions

### How do backups work in GCP ? 

Currently, we are offering only GCE snapshots which allows also a restore. A more solid solution is being assessed.

### How do I access the VM? 

If it is domain joined, you can use the FQDN or private IP inside Henkel. If it is not domain joined, you have to use OS Login and the IAP tunnel/IAP desktop application.

### Why are patch schedules and restart enforced? 

IF there is no patch/reboot schedule mentioned to the LZ team, Henkel will enforce automatic rebooting after patching to ensure machines are rebooted in frequent cycles; otherwise security and OS patches are not fully applied.

### How does the operations support work?

In the long-term this will be with dx GTC IOC (Infrastructure Operations Center) for defined objects (Virtual Machines). In short term, there will be temporary support from externals who provide the services.

### Does anything change with my application? 	

The underlying infrastructure changes due to the migration. Naturally, IP addresses and VLANs on network layer must change but the hostname would remain the same. Also, the operational model will change as we move out of existing maintenance agreements insourcing the operations.

### Does my application require a security assessment prior to migration?

Yes, please perform the security assessment, and update Alfabet security data type classification. Please also update any TOMs before and after the migration.

### How is the applicaiton hosting being billed?

Billing based on infrastructure costs, an uplift for licenses and common required tools. We will be providing you a monthly billing report information if needed (consumption)

### What do I need to consider for the next KP (Cost Planning)?	

You will need to consider app life duration, any user to license count ratio, and if there are app specific future state plans. Please reach out to your Finance Expert or Datacenter Finance team.

### What is project Falcon and Who is the Migration Team? 	

Skywalker Migrations (project Falcon is part of that) is responsible for migrating all of henkels applications to the new platforms within hybrid cloud. The team is made up of System Engineers, Cloud Architects, and Project Managers from dxV and dxR. You can reach out to the migration team for any questions at `cloud_migration@henkel.com` and the program team at `hcs@henkel.com`

### What can I do to support the migrations?

If you are an App owner, we will engage and work with you throughout the migration process. Please inform your application management team about the change and plan in some testing capacity during the migration.

### How are the migrations being performed?	

Mostly lift and shift, i.e. moving a virtual machine to another location. The application data is usually not touched. The Cloud Migration team,is working with the latest Cloud tools and technologies, to migrate apps in an efficient and seamless manner. 

### When will the migrations occur?	
The first pilot migration activities started in 2022, will peak in 2023, and continue to be operational in 2024.

### What is being migrated?	

There is a focus on migrating apps out of Henkel (local/regional IT) locations, Kyndryl (former IBM GTS), Unisys and Digilab supported apps as well.

### Where are we migrating to?

According to the Hybrid Cloud Strategy, there are three possible places:

- Public Cloud: Google Cloud and Microsoft Azure (their DC locations are near the IT Hubs of Henkel)
- Private Cloud: Equinix colocations, where we have our regional IT Hubs (Frnakfurt, New York, Singapore)
- Edge Locations: local onpremise hardware at the (factory) site. Very much depending on the application exception that is being decided.

###  Why are we doing this migration?

This is part of the new Hybrid Cloud Platform strategy. We are migrating onto the Cloud (Public and Pricate) for improved system controls, tools, monitoring, performanc, and business continuity.

### How long will my migration last?

Depending on the application complexity and dependencies the entire lifecycle from planning until PTO (production takeover) can take and estimated 2-3 weeks. 

### how long will the downtime be?

This timeframe will be identified during the initial stages of the migration planning. Since every application has its own complexity and dependencies.

### Do I need to consider 3rd Party support?

Yes - if the application is supported by a 3rd party supplier and need special knowledge for testing, please consider. 

### Who will support the infrastructure in the new platforms?

Henkel's DxV has built internal support teams with Henkel dx GTC and temporary external support to maintain the infrastructure operations within each landing zone. The SNOW groups have been created and will be auto identified when the asset is populated within SNOW. 

### Will the Service Level Agreements (SLA) change?

There will be no SLA, but in an intenral operation SLI and SLO will be placed, according to the principles of SRE. We are aiming to improve on the Service Level Indicators/Objectives when it comes to supporting incidents and changes. 