# SonarQube

SonarQube is a scanning tool for static code analysis, code quality and security and is available to all projects from the DevSecOps initiative.

## Onboarding

Please reach out to the DevSecOps or [Cloud Team](mailto:cloud@henkel.com) working group to guide you on onboarding.

## Usage

### Azure DevOps

- You need to have the SonarQube extension installed in the organization. [Azure DevOps henkel dx organization](https://dev.azure.com/henkeldx) has it already installed.
- Create a project in SonarQube.
- Create a project Key for it (this is the API key)
- Create a service connection in your AzDO project:
  - ServiceConnection: SonarQube
  - Server URL: `https://sonarqube.henkelgroup.cloud/`
  - Token: `<your token from sonarqube>`
  - Service Connection name: `sonarqube-sc`
- Create a variable group named e.g. `SONARQUBE_VARS` and put following values in it:
  - projectKey : your API key (as secret)
  - projectname : your SonarQube project name
  - alternatively, user Azure Key Vault to store the credentials.

Use following pipeline steps:

```yaml
# Sample Sonarqube pipeline

variables:
- group: SONARQUBE_VARS

trigger:
  branches:
    include:
    - master

stages:
- stage: scan_dev
  displayName: Scan with SonarQube
  jobs:
    - job: scan
      displayName: Scan with SonarQube
      pool:
        vmImage: 'ubuntu-latest'
      steps:
        - task: SonarQubePrepare@4
          inputs:
            SonarQube: 'sonarqube-sc'
            scannerMode: 'MSBuild'
            projectKey: $(projectkey)
            projectName: $(projectname)
            extraProperties: 'sonar.sourceEncoding=UTF-8'
          displayName: 'prepare sonarqube scan'
        - task: SonarQubeAnalyze@4
          displayName: 'run sonar analyzer'
        - task: SonarQubePublish@4
          inputs:
            pollingTimeoutSec: '300'
          displayName: 'publish to sonar instance'
```

- run the pipeline
  
!!! info
  The Developer Edition allows also to scan specific branches.

Additional info can be found on the [official documentation](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-azure-devops/).

### On your local machine

You can use the [sonarscanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/) tool to scan the code and send off the results to the SonarQube server. To do so (example for windows):

- Download the sonar scanner and install java
- create a sonar config file in your code repository

sonar-project.properties:

```bash
sonar.projectKey=sparc
sonar.projectName=SPARC
sonar.sourceEncoding=UTF-8
```

- execute the sonarscanner (Windows)

```cmd
cd <my code repository>
<path to sonar scanner client>\sonar-scanner.bat
```

- Unix:

```bash
# cd into the scanner directoy
~/sonar-scanner-4.6.0.2311-linux/bin/sonar-scanner \
  -Dsonar.projectKey=<YOURPROJECTNAME> \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://sonarqube.henkelgroup.cloud \
  -Dproject.settings=sonar-scanner.properties \
  -Dsonar.login=<YOURLOGINNAME> \
  -Dsonar.password=<YOUR_API_TOKEN_> \
  -Dsonar.branch.name=<OPTIONAL:YOUR_BRANCH_NAME>
```

Visit the dashboard
