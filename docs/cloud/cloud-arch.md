# Cloud Architecture Guardrails

This section is a condensed working whitepaper out of the Cloud Governance Model

## Infrastructure Security Checklists

We separated the Security Checklist out to be specific for the cloud platform

- [General](../security/security.md)
- [Azure](../security/infrastructure/azure.md)
- [GCP](../security/infrastructure/gcp.md)
- [Terraform Development](../howto/getting-started-terraform.md)

## How to select the right Cloud Service for my needs?

- Container based application design is Henkels default
- Limit the variety of CSP services that may lead into higher maintenance effort and need of too many different specialized people skill
- Virtual Machines are fall back solutions and no default in opposition to container
- Storage Services should leverage interoperable or agnostc protocols that are encrypted (e.g. SMB, NFS)
- SQL with Postgres and MariaDB are prefereable database engines
- Public Cloud Marketplace Offers are to be confirmed by Cloud Team if not issued by actual Public Cloud Provider
- New Services must pass a [Service Enablement Framework](./azure/sef/introduction.md) in order to be released in the Landing Zones

## What to consider if I need to integrate the Cloud Services?

The guidlinesis that secure and internet exposed or Henkel Zscaler integrated Applicaitons shall be perferered over an on-premsise integration. This increases the security posture to be zero-trust and resolved challnages that are common with IaaS workloads relying on IP based configurations ( e.g. SAP API is better that RPD over private Endpoint if available)