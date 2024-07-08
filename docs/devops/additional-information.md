## When can I apply for a GitHub Enterprise license?

Currently, GDPR approval for GitHub usage is pending. As soon as the approval is in place you can apply for a GitHub Enterprise license.

## When can I request activation of GitHub Advanced Security feature for Azure DevOps Repos?
GitHub Security feature is a new feature in Azure DevOps and it is currently under evaluation by DXS/Cyber Security Consulting team. 
We will update this entry as soon as we receive further information from the evaluating team. 
In case of additional questions, please contact POC owner: Alexander Jendrosch.

### How do I request a Service Connection?

Our DevOps team does not create Service Connections as we don't have permissions for accessing every Azure subscription within Henkel. 
You can open a support request in the Cloud Portal. It is important to mention the subscription and resource groups and also ask the team to add the SPs as contributor on the resource groups. For creating service connections from Azure DevOps, we can recommend the next steps as preparation:

1. In Azure: The user must have a specific role assignment on the resource group.
1. In Azure DevOps organization settings: The project administrator of the user who must create the Service Connection must make sure the user has Basic access level. Go to Organization settings – Users and check the
   name of the user. If the user has Stakeholder access level, you can request the change to Basic access level at this link: [Henkel ServiceNow](https://henkelprod.service-now.com/sp?id=sc_cat_item&sys_id=e46475d41b5cf89097eaea836b4bcb11).
   If the user is an external user and not part of the organization yet, send an email to [devops_support@henkel.com](mailto:devops_support@henkel.com) to add the user to the organization with Basic access.
1. In Azure DevOps project: The project administrator has sufficient permissions to invite the user to the project. The project administrator must make sure to add the user the Endpoint Creator group in 
project settings: Project settings > Service connections > Security.

### How is Necessity / Data Minimization ensured in Azure DevOps?
To ensure the Necessity & Minimization principle, we strongly recommend all users to avoid entering personal information in the Azure DevOps tool's free-text fields as a data minimization measure.

### How can I use Azure DevOps securely and compliant to SIS requirements about change management?
Agile methodologies using Azure DevOps are per se not sufficient to comply with CSIS; project managers need to take additional efforts to
 ensure CSIS compliance. Several dx teams (dxT, dxM, dxV, dxS) have created a guideline about CSIS-compliant change management when using
  agile methods and Azure DevOps. This guideline at hand explains possible ways to use Azure DevOps securely and compliant to CSIS. 
  You can find the Agile Change Management document [here](https://henkelgroup.sharepoint.com/teams/InformationSecurity/CSIS/CSIS%20documents/Forms/by%20topic.aspx). 

## How can I find or change the region of where my Azure DevOps project data is hosted?
Each Azure DevOps organization has a specific region (more info on possible data locations for Azure DevOps [here](https://docs.microsoft.com/en-us/azure/devops/organizations/security/data-location?view=azure-devops)). 
Reasons for choosing a specific region are based on locality and network latency, or because of sovereignty requirements for data centers. You can check your Azure DevOps organization region by going to Organization settings - General - Region.

Due to known Azure DevOps project limitation within an organization, the DevOps team has prepared several Azure DevOps organizations, managed by DevOps team, in different regions:

- [Organization henkel-west-europe, region West Europe](https://dev.azure.com/henkel-west-europe/)

- [Organization henkel-east-asia, region Southeast Asia](https://dev.azure.com/henkel-east-asia/)

- [Organization henkel-central-us, region Central US](https://dev.azure.com/henkel-central-us/)

- [Organization henkeldx, region West Europe](https://dev.azure.com/henkeldx/) 

Responsibility of data protection falls under the responsibility of the Information Asset Owner who needs to be in contact with the responsible Data Privacy Delegate, more info [here](https://portal.de.henkelgroup.net/irj/portal/Global/8AMDB6216SFAP).

[Azure DevOps]: https://dev.azure.com/
[GitHub]: https://github.com/
[myID]: https://myid.henkelgroup.net/
[Henkel DevOps Team]: https://henkelgroup.sharepoint.com/teams/DevOps/SitePages/DevOps.aspx
[Azure DevOps Marketplace]: https://marketplace.visualstudio.com/azuredevops
[Henkel dx]: https://dev.azure.com/henkeldx
[Henkel GitHub]: https://github.com/orgs/henkel/teams
[Henkel Portal]: https://portal.de.henkelgroup.net/irj/portal/

## How to request a new Azure DevOps organization

Please see this [link](https://docs.henkelgroup.cloud/howto/request-azuredo/)