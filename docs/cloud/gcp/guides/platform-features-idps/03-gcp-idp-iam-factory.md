## GCP IAM factory

# lz-iamfactory-config-henkel

## Purpose

This repository is designed to manage IAM (Identity and Access Management) policies via the IAM factory Terraform code located in the [lz-iamfactory-henkel](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/lz-iamfactory-henkel) repository.

The IAM factory supports three primary methods for defining IAM permissions:

1. **Project Level**: Applying IAM permissions directly to a specific project.
2. **Folder Level**: Setting IAM permissions at the folder level, influencing all contained projects.
3. **Organization Level**: Configuring IAM permissions at the highest hierarchy, the organization, which will cascade down to all folders and projects within.

Permissions are then applied at the respective level indicated by the definition. The permissions are additive, so in theory they should not override any permissions granted outside of the IAM Factory.

## Directory structure

# IMP NOTE: Starting from 21.04.2024 all the IAM factory confix yamls have been moved/migrated to new dir structure i.e.  henkelcom and henkeltestcom
This repository primarily consists of:

- environments
- examples
- gitlab-ci
- henkelcom
- henkeltestcom
- factory-migration

The `environments` folder contains configurations for various stages like "dev", "dev-dmz", "prod", "prod-dmz", "shared", "test", and "test-dmz".

The `examples` directory houses descriptions for a range of sample IAM configurations.

The `gitlab-ci` directory encapsulates CI templates and scripts, which initiate the pipelines to apply the IAM policies to their designated projects, folders, or organization resources.

Within the `henkelcom` directory, you'll manage IAM policies in yaml files for Henkel GCP Production Organization i.e. henkelcom. This structure facilitates the organization of permissions based on your desired hierarchy: "application_name-country_code/environment" or directly at the project, folder, or organization level. It's paramount to ensure clarity in file organization, avoiding the extremes of having a file for each policy or consolidating all into one, as both can be challenging to manage.

Within the `henkeltestcom` directory, you'll manage IAM policies in yaml files for Henkel GCP Nonprod/Sandbox Organization i.e. henkeltestcom. This structure facilitates the organization of permissions based on your desired hierarchy: "application_name-country_code/environment" or directly at the project, folder, or organization level. It's paramount to ensure clarity in file organization, avoiding the extremes of having a file for each policy or consolidating all into one, as both can be challenging to manage.

The `factory-migration` directory contains a set of helper scripts that support with the migration of current IAM policies from the Project Factory Config to this repository (including the state)

---

## Provisioning IAM policies

To create IAM policies in production org henkelcom, draft a `.yaml` located in the correct path in the henkelcom directory.
- Project Level: `henkelcom/projects/<application-name>-<country-code>/<environment>`
- Folder Level: `henkelcom/folders/folder-<folder-name>`
- Organization Level: `henkelcom/<organization-name>`

To create IAM policies in Nonprod/Sandbox org henkeltestcom, draft a `.yaml` located in the correct path in the henkeltestcom directory.
- Project Level: `henkeltestcom/projects/<application-name>-<country-code>/<environment>`
- Folder Level: `henkeltestcom/folders/folder-<folder-name>`
- Organization Level: `henkeltestcom/<organization-name>`



For the environment folders make sure to choose one of the following: tst, tst-dmz, prod, dev, dev-dmz

For the assignment of the IAM bindings, two different yaml-files are to be created, which serve for a better manageability of the roles: 
- high_privileged_iam_members.yaml: all *admin and highly privileged roles
- iam_members.yaml: all (other) without admin or highly privileged roles

The following YAML structure/syntax must be used: 
```yaml
project_id: YOUR_PROJECT_ID
(high_privileged_)iam_members:
  - member: group:...@henkel.com
    roles:
      - role: YOUR_ROLE_1
      - role: YOUR_ROLE_2
      - role: YOUR_ROLE_3
        condition:
          title: CONDITION_TITLE
          expression: CONDITION_EXPRESSION
          description: CONDITION_DESCRIPTION
```

After finalizing the `.yaml`, initiate a `feature/<name>` branch, commit your file, and start a merge request. The pipeline associated with the merge request will generate a plan. Should any discrepancies arise, rectify them to align the plan with your intended outcomes.

## Grant IAM roles to Service Account(s).

To create IAM policies in production org henkelcom, draft a `.yaml` located in the correct path in the henkelcom directory.

- Service Account Binding: `henkelcom/service-accounts/<application-name>-<country-code>/<environment>`

For the assignment of the IAM bindings, below yaml-files needs to be created, which serve for a better manageability of the roles: 
- iam_members.yaml: Service account binding roles.

The following YAML structure/syntax must be used: 
```yaml
service_account_bindings:
  - service_account_id: SERVICE-ACCOUNT@PROJECT-ID.iam.gserviceaccount.com
    iam_members:
    - member: group:MYID/AAD-GROUP-NAME@henkel.com
      roles:
      - role: YOUR_ROLE_1
      - role: YOUR_ROLE_2
      - role: YOUR_ROLE_3
        condition:
          title: CONDITION_TITLE
          expression: CONDITION_EXPRESSION
          description: CONDITION_DESCRIPTION
```
After finalizing the `.yaml`, initiate a `feature/<name>` branch, commit your file, and start a merge request. The pipeline associated with the merge request will generate a plan. Should any discrepancies arise, rectify them to align the plan with your intended outcomes.

## IAM Conditions
Conditions are optional. 
Conditions can be completely excluded from the yaml if none are available. This also makes the yaml look much more structured and uniform.

If a role with condition is to be added, it must be described as below example which is project level IAM role assignment with condition:
```yaml
project_id: hmcp-prd-o365sk-sk-prj-vz2
iam_members:
- member: serviceAccount:service-432986388226@gcp-sa-vmmigration.iam.gserviceaccount.com
  roles:
  - role: roles/iam.serviceAccountUser
    condition:
      description: test-condition
      expression: 'request.time < timestamp("2024-01-01T00:00:00Z")'
      title: test
```
Important Note: Be aware that adding a IAM condition to existing IAM role assignment will result in the resource being destroyed and having to be recreated.

## IAM Deny policies

IAM Deny Policies allow you to explicitly deny permissions to specific resources in Google Cloud Platform. Unlike the "allow" policies, which permit actions, a "deny" policy will explicitly prohibit specific operations from being performed by particular identities.

You can find an example in the `examples` folder. Finde more documentation [here](https://cloud.google.com/iam/docs/deny-overview#deny-rules).

Things to keep in mind:
- You can attach the deny rules at org, folder or project level
- You can only attach up to 5 deny rules to one instance (each of those can contain multiple rules)
- You need to use [IAM V2 API](https://cloud.google.com/iam/docs/deny-overview#deny-rules) pricipel identiifiers
- For groups you need to use the email that is mentioned on groups.google.com (most of the time it is uppercase, the lowercase one is an alias that can't be used)
- The policies use the Service FQDN that you can find [here](https://cloud.google.com/iam/docs/deny-permissions-support)

## Branching Strategy

Post-approval and merge, a CI pipeline activates an automatic Terraform apply. It will momentarily pause before actual deployment. To finalize and enact your configurations, press `play`.

## ToDos and hints

I already started to test the migration of the environments. That's why you will find some import iam binding scripts (they can be deleted once the state is imported btw). These projects are:
Security DE DEV
Security DE DEV DMZ
O365 SK Test
Omigtlb DE Test
Wife DE Test
Security DE Test DMZ
O365sk prod plan
tDS DE prod dmz

You will also find some deprecated state files in the gcs bucket (iam-factory in the seed project). These are from tests with different environment names, but the not needed ones could be deleted.

For folders the names shows up twice in the state file name. This is due to this line in the template-gitlab-ci-main.yml 
  TF_INIT_FLAGS: "-reconfigure -backend-config=bucket=${BUCKETNAME} -backend-config=prefix=henkel/${HENKEL}/iam-factory/${PROJECT}${FOLDER}/${ENVIRONMENT}"
This is still from the Google PSO because there is no differentiation between Projects and folders in the ci pipeline for now. For folders there is still the folder name set as a project variable because otherwise the pipeline would fail.


## Troubleshooting 

Q: The pipeline did not start or there is no job displayed
A: Make sure that there was a change in your directory (e.g. definition-files/projects/yourproject/dev). If the yaml file inside of this directory did not change, no pipeline will run. Also make sure that you used the correct environment name (test, test-dmz, dev, dev-dmz, prod, prod-dmz) and not prd, or tst.