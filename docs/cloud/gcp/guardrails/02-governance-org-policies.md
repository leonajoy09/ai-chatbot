## Governance Policies

**Overview**

- on GCP, Most of the governance policies are enforced in the form of GCP native [Organization Policies](https://cloud.google.com/resource-manager/docs/organization-policy/overview)

- Platform and dxS Security team have collaboratively deployed the GCP organization poilices as IaC via terraform and Gitlab CI/CD pipeline.  

- All the enforced/active GCP organization poilices are maintained in this [Organization Policies Gitlab Repo](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/lz-01-org-henkel/-/blob/main/terraform/org-policies-v2.tf?ref_type=heads)


**How to request exemptions to Org policies ?**  

- If you wish to request exemptions for perticular org policy on your project level then you must submit it in the form of MR (Merge Request) in the [Organization Policies Gitlab Repo](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/lz-01-org-henkel/-/blob/main/terraform/org-policies-v2.tf?ref_type=heads).  

- The MR will be reviewed/approved either by Platform or dxS Security team. 