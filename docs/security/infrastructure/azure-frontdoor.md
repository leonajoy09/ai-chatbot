# Azure Infrastructure Security - FrontDoor Assessment

__WORKING VERSION - DRAFT__

State: Scope release for certain projects
Date: June 2022
 
## Checklist

1. All personal identities must be managed by Azure AD as centralized identity and authentication system --> [Identity & Security Gov](../) | [ABC]()
2. Azure IaaS (VNet, Bastion, VM) creation is restricted to come from Skaylink IQ3 only --> [Request Vnet]() 
3. Test and Prod systems are changed by infra-as-code automation piplines --> [Azur Devops guidlines](https://dev.azure.com/henkeldx/Terraform-Modules/_git/Azurerm) | 
6. Terrform code is scanned by checkov.io integration as similar [Checkov.io](https://www.checkov.io/) | [Guideline to implement (soon)](../)
7. Imperativ code is scanned from ...  --> [request integration into SQ](../) (TDC/ INACTIVE)
8. Azure Defender for Cloud Recommendation are handled with documentation  evidence from High to Medium
9. Cloud Governance Model is adhered at all times --> [Cloud Governance Model](../../cloud/cloud_governance.md)

!!!Info
    - For TDC/ INACTIVE, please approach Cloud Security team if applicable
    - An alternative to 3. - we intent to provide an central terraform Azure VNet Module --> [Terraform Modules IQ3 (WIP)](https://dev.azure.com/henkeldx/Terraform-Modules/_git/Azurerm) 

## Approved Azure Services 

For better orientation we intend to provide the architecturally approved Azure Services via
[Azure DevOps Repo](https://dev.azure.com/henkeldx/Terraform-Modules/_git/Azurerm). Please watch the section's Status in the header