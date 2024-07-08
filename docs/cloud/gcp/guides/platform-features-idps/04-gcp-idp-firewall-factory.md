## GCP Firewall factory

# lz-firewallfactory-config-henkel

## Purpose

Use this repo to create firewall rules using the firewall factory Terraform code located in the [lz-firewallfactory-henkel](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/lz-firewallfactory-henkel) repository.

The firewall factory code repo is environmental and organizational independent, and will use the variables of the environment terraform.tfvars files from this repo as the config.

For example, using `type : dev-dmz` will create firewall rules in dev-dmz host project using the `terraform.tfvars` file from `environments/dev-dmz/terraform.tfvars`

## Prerequisite knowledge needed to create firewall rules

- Access to the Gitlab instance
- Access to the firewall factory configuration repo (create branch, merge branch)

## Directory structure

In this repository several main directories are defined :

- environments
- examples
- firewall-factory-validator
- gitlab-ci
- henkelcom

The `environments` folder includes the different stage configurations for "dev", "dev-dmz", "prod", "prod-dmz", "shared", "test" and "test-dmz".

In the `exmaples` folder you find the description for some example firewall configurations

The `firewall-factory-validator` is used to validate the configuration of the firewall rules

The `gitlab-ci` folder covers the CI templates and scripts to generate the neccessary pipelines to create the firewall rules in the desired shared VPC.

In the `henkelcom` folder you create the firewall rules in yaml files in subdirectories "application_name-country_code/environment". The app_name is corresponding to the yaml configuration file of the project factory and the country_code is similar to the file [country_codes](https://gitlab.gcp.henkelgroup.io/lzi-tf-modules/terraform-google-gcp-base-project/-/blob/main/terraform/files/country_codes.json). All yaml files added to this repo under the `henkelcom/` must have one the names listed below. These files will be planned and potentially applied on successful merge.

Allowed yaml file names:
- `egress_allow.yaml`
- `egress_deny.yaml`
- `ingress_allow.yaml`
- `ingress_deny.yaml`
- All other yaml files will be ignored

---
## Provisioning firewall rules

To create firewall rules in the specific host project you need to provide at least one file in `.yaml` format.

After filling out the `.yaml` create a `feature/<name>` branch, and upload your file to the branch. Create a merge request and wait for centralized approval by colleagues from the `Edge Security` team.
The merge request pipeline that is triggered will present the plan. If anything fails, you can fix the problems until the plan shows the expected result.

## Branching Strategy

Branches are named `feature/*` will trigger a terraform plan, when a Merge Request is opened.

After approval and merge the CI pipeline triggers automatically a terraform apply, that will pause before the real execution. You have to press on `play` to finally apply your configuration.