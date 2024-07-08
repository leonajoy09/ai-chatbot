# DevSecOps concept on Hybrid Cloud

While the existing concepts for Azure remain a valid approach, we introduce new toolings and processes in Hybrid Cloud Platform to manage infrastructure for the Platform team. This can be adopted by Application teams and is recommended to follow.

## Cross-platform CI/CD solution

### Azure DevOps

Azure DevOps is continuously supported by integrating it into GCP.

With Google's [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation), you can establish a trust connection between Azure DevOps and Google Cloud Platform. The authenticated Pipeline uses Henkel's Azure AD tenant to verify its identity. In your GCP project, an identity pool is set up, so that project's GCP service account can be connected to this. Using this mechanism it is possible that your CI/CD pipeline deploy resources into GCP.

From the Azure side, you need a sevice connection and a service principal that can query the Azure AD graph API for identity authentication and use that SP to match against the workload identity and a google service account.

Henkel Cloud Team provides a platform-independent docker base image at `hcsgcp.azurecr.io/henkel/adotools-debian` for gcloud CLI and terraform CLI accessing in your pipeline run tasks.

#### Implementation hints

```bash
AZURE_TOKEN=$(az account get-access-token --query accessToken --output tsv)
echo "##vso[task.setvariable variable=AZURE_TOKEN;isoutput=true]$AZURE_TOKEN"
```

```json
{
  "type": "external_account",
  "audience": "//iam.googleapis.com/projects/PROJECT_ID/locations/global/workloadIdentityPools/azure-devops-pipeline/providers/azure",
  "subject_token_type": "urn:ietf:params:oauth:token-type:jwt",
  "token_url": "https://sts.googleapis.com/v1/token",
  "credential_source": {
    "file": "/home/vsts/work/1/s/Azure-Pipeline/token.txt",
    "format": {
      "type": "text"
    }
  },
  "service_account_impersonation_url": "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/YOUR_SERVICE_ACCOUNT:generateAccessToken",
  "service_account_impersonation": {
    "token_lifetime_seconds": 3600
  }
}
```

azure-pipelines.yml:

```yaml
- stage: 
    dependsOn: Code_Test
    displayName: Azure_token
    jobs:
      - job: init_job
        displayName: Initialize Credentials
        timeoutInMinutes: 1
        steps:
          - task: AzureCLI@2
            name: get_azure_token
            displayName: Get Azure Token
            inputs:
              azureSubscription: YOUR_AZURE_SERVICE_CONNECTION_AND_PRINCIPAL
              scriptType: bash
              scriptLocation: scriptPath
              scriptPath: ./Azure-Pipeline/get-azure-token.sh 
              # [SEE_ABOVE how to fetch token]
      - job: Build_and_Copy
        displayName: Build_and_Copy
        timeoutInMinutes: 30
        dependsOn: init_job
        #container: gcp-terraform
        variables:
          AZURE_TOKEN: $[ dependencies.init_job.outputs['get_azure_token.AZURE_TOKEN'] ]
          GOOGLE_APPLICATION_CREDENTIALS: ./Azure-Pipeline/gcp-credential-source.json
          # [SEE_ABOVE jsong credentials config]
        steps: 
          - checkout: self
            fetchDepth: 1
          - task: Bash@3
            name: provide_azure_token
            displayName: Provide Azure Token
            inputs:
              targetType: inline
              script: |
                echo $AZURE_TOKEN > ./Azure-Pipeline/token.txt
                cat ./Azure-Pipeline/token.txt
          
          - task: DockerInstaller@0
            displayName: Install Docker 17.09.0-ce
          - task: Docker@2
            displayName: build
            inputs:
               repository: ... 
               command: build
               Dockerfile: dockerfile
               Tags: latest

          - task: Bash@3
            name: dockerpush
            displayName: dockerpush
            condition: eq(variables['build.sourceBranch'], 'refs/heads/main')
            inputs:
               targetType:
               script: |
                 gcloud auth login --cred-file=./Azure-Pipeline/gcp-credential-source.json
                 print "Y" | gcloud auth ... 
                 docker images
                 docker push ...
                 gcloud config get account
                 gcloud run deploy ...
```

!!! info
    read more here:
    - [GitLab and WIF](https://medium.com/google-cloud/gitlab-and-workload-identity-federation-on-google-cloud-a0795091e404)
    - [Azure DevOps and WIF](https://medium.com/google-cloud/accessing-google-cloud-apis-from-azure-devops-using-workload-identity-federation-6acc5ad1a071)

### GitLab

Hybrid Cloud Platform Administrators will have access to a **GitLab** instance which allows us to manage git repositories as self-contained solutions on a specific platform. For Private Cloud and GCP we will build one GitLab instance each, which allows independent source code storage. Each premium license user is eligible to push/pull data from each source for repo syncing.

!!! info
    During rampup phase, usage of the GitLab MVP applies to a selected audience only.

## Terraform Enterprise (TFE)

CI/CD is used to deploy infrastructure as code using Terraform.

Terraform Enterprise allows us to centrally govern infrastructure as code, set policies to allow/disallow services based on stages and have terraform statefiles at one central place. It should ease your application infrastructure deployment and workd across our cloud platforms. Terraform enterprise also allows you to keep you state up to date and detect drift detection.

!!! info
    Terraform Enterprise is not available yet.

## GitOps

The GitOps concept is used to check in code and automatically let it being deployed, often used in the context of kubernetes. ArgoCD or GKE Config Management help to manage self-regulating deployments that check the state drift each time. Alert hooks can help to notify you when a deployment happened or issues on the deployment happened.

## Configuration Management

Ansible is the chosen tool to configure stateful resources such as Virtual Machines that need continuous maintenance. We will provide example code how to maintain your machines.

On GCP, OS Patch Management is activated by default for all Google Compute Engines. On *platform team managed* VMs we apply Ansible to configure the VM with defautl settings for

- Henkel Proxy
- Setting of Henkel DNS servers
- Endpoint detection
- DevSec hardening guidelines (includes CIS)

## Artifact binary store

For storing docker images, binary files and libraries, use Artifact Registry (do not use the deprecated Container Registry).  In a later stage, we will introduce an Enterprise Artifact Store for hybrid DevOps.
