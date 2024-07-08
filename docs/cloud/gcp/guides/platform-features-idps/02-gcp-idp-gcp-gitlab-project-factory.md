## GCP Gitlab project factory

# gitlab-project-factory-config

This repository contains the configurations for resources related to the Henkel Gitlab instance. The folder structure is split between gitlab-groups and gitlab-projects.

- gitlab-groups is primarily to be used by the platform team to organize projects and permissions.
- gitlab-projects should be used by individual teams to provision gitlab projects and gitlab runners that can be used to deploy resources to GCP, using Terraform (IaC).

## Gitlab projects

A gitlab project consists of a repository for the terraform code, and a CI/CD (build/deploy) automation tool (Gitlab Pipelines) that can be used to provision resources to GCP. Please see the official [gitlab documentation](https://docs.gitlab.com/ee/ci/pipelines/) on how to configure your gitlab pipelines. In the gitlab-projects folder, subfolders are created for workloads/teams that can contain multiple YAML configuration files. Each YAML file corresponds to a single gitlab project, and can specify standard values to use for the project configuration e.g:

```yaml
# yaml-language-server: $schema=https://storage.googleapis.com/hmcp-gcp-platform-schemas/gitlab-project-factory/v1.3.0/gitlab-project-schema.json

lz-cvation:
  name: lz_cvation_tst
  path: hmcp-gcp
  description: "This project is used for cvation cloud adoption testing workloads"
  main_branch_protection: false
  create_initial_files: true
  prepare_semantic_versioning: false
```

The first line points to the schema that should be followed for the gitlab projects, and the version of the gitlab project factory "engine". Whenever new features are implemented, the version can be upgraded using the {VERSION} portion of the path in the first line `# yaml-language-server: $schema=https://storage.googleapis.com/hmcp-gcp-platform-schemas/gitlab-project-factory/{VERSION}/gitlab-project-schema.json`.

### Permissions

If specific permissions on the project level need be added, it can be specified in the blocks as exemplified below. Permissions are also inherited from gitlab-groups (collections of projects) described above. Bear in mind, these are not the same groups as defined in the below, as these are groups of users.

```yaml
# yaml-language-server: $schema=https://storage.googleapis.com/hmcp-gcp-platform-schemas/gitlab-project-factory/v1.3.0/gitlab-project-schema.json

lz-cvation:
  ...
  user_permissions:
    - user_id: 173
      access_level: owner
  group_permissions:
    - group_id: 438
      group_access: maintainer
```

#### Known issues

Currently there is an issue with the `create_initial_files` parameter which is used to create some "blueprint" files for the gitlab project being provisioned. The files become corrupted when provisioned, and the platform team will work on adjusting this.

## Gitlab runners

Gitlab "runners" is the name for the compute agents used in Gitlab to execute the jobs in the CI/CD pipelines. In Henkel, runners are provisioned in a GKE cluster and use workload identity federation to communicate with GCP.

To be able to deploy resources to GCP, runners must be configured for the gitlab project, and configured with a GCP service account that has the necessary permissions in GCP to deploy to a GCP project.

A gitlab project can have multiple project runners. The recommended setup for a workload that has e.g. a `test`and `production` environment would be to have a runner for each environment, configured with the respective GCP project service accounts, as depicted below. This allows you to keep terraform configurations reproducable and consistent across environments, while targeting deployment to GCP to the respective environments.

![alt text](image.png)

Runners can be configured as below and must use version >= `v1.3.0`. The runners will be registered to your project as part of the deployment pipeline for the gitlab project factory.

```yaml
# yaml-language-server: $schema=https://storage.googleapis.com/hmcp-gcp-platform-schemas/gitlab-project-factory/v1.3.0/gitlab-project-schema.json

lz-cvation:
  ...
  runners:
    - app_name: cvation
      environment: tst
      gcp_service_account: hmcp-f-tst-cv-sndbx-sa-proj@hmcp-tst-cv-sndbx-de-prj-yjv.iam.gserviceaccount.com
      tags:
        - tst
        - cvation
    - app_name: cvation
      environment: prd
      gcp_service_account: hmcp-f-prd-cv-sndbx-sa-proj@hmcp-prd-cv-sndbx-de-prj-abc.iam.gserviceaccount.com
      tags:
        - prd
        - cvation
```

The `tags` property must specify a unique set of _keywords_ that should be used in your gitlab pipeline jobs to target a specific runner. In other words, if a pipeline job has the `tst` and `cvation` tags specified, the job will be "picked up" by the `tst` runner. In the above case, this runner has access to use the service account `hmcp-f-tst-cv-sndbx-sa-proj@hmcp-tst-cv-sndbx-de-prj-yjv.iam.gserviceaccount.com` that is allowed to deploy resources to the GCP project.