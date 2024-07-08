# Getting Started

## Identify your demand

In order to start off with Google Cloud, you must use the [Cloud Portal](https://cloudportal.henkelgroup.cloud/#/) to raise your demand. The team will reach out to you and consult in order to collect information and check all metadata required. We need budget information (Clarity Code), application asset information ([Alfabet](https://henkel.alfabetcloud.com/Home.aspx)) and an architectural description of the solution.  

## Request a Google Cloud project

- You request the project in the cloud portal and will be rooted to Hybrid Cloud (GCP) team.
- You will need to provision an Azure AD group and a shared mailbox for notifications
- Attach the architecture description or a free text description
- The project will be provisioned by the landing team after security operations has reviewed security measures on the solution


!!! info
    You automatically accept our terms of use with that. 

## Obtain Access

Once we have created the Google Project via Project Factory for you, you will be able to log in with the Google Cloud Console, the Google Cloud CLI and use APIs in order to deploy infrastructure with terraform.

!!! info
    Since you cannot just log on with the standard URL but need to run through GCP, use the following link to access the GCP Landing Zone: 
    [Henkel.com (prod)](https://myapps.microsoft.com/signin/3462efa2-3e63-4d29-9634-cb8ffc2357e6?tenantId=e8701075-0d9e-4ea1-991d-5a0d110a5d29)

## Develop and deploy application

You can choose between using Azure DevOps or GitLab. We discourage you to use Google's native Cloud Source Repositories and Cloud Build, as their capabilities on team collaboration are limited and features at this stage are rather rudimentary.


## GCP Sandboxes

For POCs and time-limited sandboxes, you agree to following additional terms.

!!! warning

    In case of a sandbox, following additions apply:

    1. Cloud Governance is accepted by you, https://docs.henkelgroup.cloud/cloud/gcp/ and [Cloud Landing Zone Governance](../cloud_governance.md). 
    2. Versions of these linked sites can changed monthly and are reported in update sessions as of "COP Cloud Meetup". 
    You are invited prior to this demand to catch updates.
    3. Dependencies to team or business related processes are strictly forbidden in this environment. 
    4. Refinements needs by Cloud security must be applied in timely manner, otherwise services will be suspended .
    5. The environment is solely for learning and practicing apart from concrete business activities. Violating these aspects must be reported to Henkel compliance and risk management.


## Helpful Resources

- [Google Cloud Cheat Sheet](https://googlecloudcheatsheet.withgoogle.com/)
- [Google Cloud Services in 4 words](https://github.com/priyankavergadia/google-cloud-4-words)
- VS Code: [Cloud Code extension](https://cloud.google.com/code/docs)
- Free [Google SRE books](https://sre.google/books/)
