## GCP VPC SC factory

# Overview

This repository contains the configuration for the VPC Service Controls. The acutal terraform code is stored in the lz-vpc-sc-henkel repository.

This repository is a comprehensive configuration guide for Virtual Private Cloud (VPC) Service Controls. It was created to simplify the setup and configuration process of VPC Service Controls in a Terraform environment.

VPC Service Controls is a security feature offered by Google Cloud Platform (GCP). It allows administrators to define a security perimeter around Google Cloud resources to guard against data exfiltration. This is particularly useful in scenarios where you need to provide additional security measures to prevent data leaks.

## Folder Structure

The repostory stores the config for both orgs, that is why you will sometimes find a henkelcom/ and henkeltestcom/ folder for certain resources. 

- environments/ - Here you can find the terraform.tfvars files that are used for configuring the different environments for terraform
- henkelcom/ & henkeltestcom/ - These are used to store the configuration for the Access Level, Resources and Ingress/Engress rules
- templates/ - Used to store the terraform-factory.yml file that is used in the CI Pipeline

## Usage

If you want to add new resources like a VPC SC resource, an ingress/egress rule or an access level, here are the instructions. Keep in mind that you should test new rules, by putting then in the dry-run folder first and then promoting them to enforced.

### VPC SC rules

For each perimeter there is a vpc-sc-rules/ folder. To keep them organized they are split into ingress and engress rules + enforced and dry run. Because there are a lot of folders, please follow the following naming convention to still have a good overview when working with the vpc sc rules.


The rules files follow this naming convention:
```
<org-prefix>-<environment>-<egress/ingress>-<dryrun/enforced>-<policy-name>.yaml
```
<b>Example:</b> <br>
hmcp-nonprod-e-d-testpolicy.yaml <br>
hmcd-shared-i-e-anothertestpolicy.yaml

You can use abbreviations to make the name shorter.

### VPC SC resources

In order to map each project to the correct perimeter, we need to map them. For each project you need to create a new .yaml file for mapping the project to the perimeter. You can also use this file to control if the ingress/egress rules should be enforced or just in dry-run.
Please use this format:

```
vpc_service_controls:
  # Project number
  project_number: 1234567891
  # Environment name, decides to which perimeter the project will be added.
  # Either "prod", "non_prod" or "shared" - Please make sure to use the _ when choosing "non_prod"
  environment: "non_prod"
  # Dry-Run and Enforced mode enabled. Values: true or false
  dry_run: false / true
  enforced: true / false
```
Make sure to use the project number and not the project id or name. You can find the project number by:
1. Go to the home page of the GCP console. Select your project. Under the Google logo you can find the project number. 
2. Use this command in the cloudshell (or anywhere where you have the gcloud SDK installed)
```
gcloud projects describe <project-id>
```

ToDo: There is also a way to configure this automatically using Terraform, Stackdriver, Cloud Functions and Pub/Sub described [here](https://github.com/terraform-google-modules/terraform-google-vpc-service-controls/tree/master/examples/automatic_folder).
One limitation is that currently nested folders are not supported. That way we have to manually add a yaml for each project. Which still gives us the possibility to control the dry run and enforced mode.

## CI/CD Pipelines

In the CI/CD pipeline there is a Job for each perimeter and each environment. The pipeline clones the vpc-sc-henkel repository where the terraform configuration is stored. It then creates the resources based on the configuration.

Our CI/CD pipeline uses GitLab and is designed to automate the processes of validating, building, and deploying our Terraform configurations for VPC Service Controls across different environments - non-production, production, and shared.

The pipeline comprises various stages, each tasked with a specific responsibility:

<b>Plan Stage:</b> In the plan stage, changes in the VPC Service Control rules or resources trigger the pipeline. It then executes formatting, validation, and planning of the Terraform scripts using the .terraform:factory:fmt, .terraform:factory:validate, and .terraform:factory:build jobs.

<b>Apply Stage:</b> The apply stage is responsible for deploying the planned changes. The deployments need to be executed manually currently. It utilizes the .terraform:factory:deploy job for this process.

This pipeline is configured to handle different environments - non-production, production, and shared - each having separate plan and apply jobs.
By making use of such a pipeline, we ensure consistency and prevent potential configuration drift across environments. It helps us automate the deployment process, reduce manual errors, and deliver changes more rapidly and safely.

## FAQ / Troubleshooting

<b>Q: </b> In the terraform plan I only see resources added to the permieter but they are not mentioned as "resources_dry_run" or something like that. <br>
<b>A: </b> That is normal. If you take a look at the underlying [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/access_context_manager_service_perimeter.html#example-usage---access-context-manager-service-perimeter-dry-run](terraform resources) that get's created, you can see that the resources for the dry run are always located in the "spec" object. They just have the same names as the enforced resources that are located in the "config" object.

<b>Q: </b> My project does not get added to the perimeter if I add another yaml file. <br>
<b>A: </b> Make sure that you specified the environment correctly. E.g. upper- and lowercase + "_" instead of "-"


```alfabet
Product: App name
Owner: Owner henkel.com mail address
App-Id: Alfabet EAM App-ID
DEV-URL: DEV-URL1,DEV-URL2,DEV-URL3
QA-URL: QA-URL1,QA-URL2,QA-URL3
PROD-URL: PROD-URL1,PROD-URL2,PROD-URL3
Public exposure: internet-facing OR internal
Repo type: documentation OR sourcecode
Status: active OR archived OR PoC
```

## ToDos

- ~~Deploy the 2 missing permeter (just create the 2 folders and for gitlab ci to pick up changes add at least 1 yaml file in there that maps a project to a permeter)~~
- Testing switch from dry run to enforced mode (toggle the flag in the resource yaml and set enforced to true)
- Deploy and test ingress and egress rules
- Test access level deployment
- Create monitoring and log sink resources if needed? (Terraform code already exists)