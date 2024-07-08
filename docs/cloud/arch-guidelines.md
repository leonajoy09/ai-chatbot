# Cloud Architecture Guidelines

Following quarterly agreed architecture best practice should give better guidance for developers, providers implementing Cloud services on IQ3 / Managed Cloud.

Please find cross referenced and according Cloud Security Checklists for Azure and GCP [here]().

## Q1 2022

### Architecture Technology Evaluation and Guidlines

- Container based compute design is to be proofed first and need to prioritised over a integrated PaaS solution  (e.g.  container on an Azure App service over an Python Function App)
- Storage Services like CosmosDB should be used with interoperable protocols if available (e.g. CosmosDB with MongoAPI / SQL)
- Azure SQL with Postgres and MariaDB is to be weighted higher than Azure SQL 
### Cloud Project Integration Guardrails 

- Guardrail: Private Endpoint usage and Vnet/PVC integrated designs to be used for PaaS [Request Vnet]()
- Mandatory VNet provisioning for tst/qua/prd stages is to be requested by Skaylink IQ3 [Request Vnet]() | [Use TF Module Vnet (soon)]()
- Vnet layout follows Azure 

### Operational Excellence
- Azure Infrastructure is automated via Terraform Infrastructure as Code [Guideline of Terraform Development]() | ()[]
- Security Controls must be aligned with [Security Checklist]() at any time 

### Cloud Project Governance 
- New Demands and projects towards Cloud at Henkel are to be annouced via [Cloud Portal]() | [Get Started]()
- larger Changes and additions must be proof or announce via change in [Cloud Portal]() | [Get Started]() 



