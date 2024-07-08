In this folder there are backups for the whitesource software which are not used yet or anymore.


### Example Pipeline and Pipeline Integration

- **IMPORTANT: The Mend tasks in the example pipeline require to be adapted to the respective programming language of the application. Therefore, please follow the sub-pages for the different programming languages.**
-	It is possible to run the Mend scan in parallel to the deployment to Dev environment.
-	There are 2 stages/jobs for Mend: one for the production environment only (e.g. main branch) and one for all the other environments, meaning Non-Prod branches. This is achieved via the “condition” parameter.
  - **IMPORTANT:** Before running Mend each Job installs the respective package manager and at least installs the dependencies with the package manager
  - Afterwards Mend is running. The tasks for the Prod and Non-Prod environments are different!

````yaml
trigger:
  paths:
    exclude:
    - '*.yml'
    - README.md

pool:
  vmImage: ubuntu-latest
- task: Npm@1
  inputs:
    command: 'install'

stages:
- stage: Build
  jobs:
  - job: Build
    displayName: Build App
    steps:
    	...


- stage: Mend Prod Security Scan
  dependsOn: Build
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - job: Mend Prod
    displayName: Mend Prod Unified Agent Security Scan
    steps:
    - task: Install Package Manger
      displayName: 'Install Package Manger'
        ...
    - task: Install Dependencies
      displayName: 'Install Dependencies'
        ...
    - script: |
        echo Downloading Mend Unified Agent
        curl -LJO https://unified-agent.s3.amazonaws.com/wss-unified-agent.jar
        if [[ "$(curl -sL https://unified-agent.s3.amazonaws.com/wss-unified-agent.jar.sha256)" != "$(sha256sum wss-unified-agent.jar)" ]] ; then
          echo "Integrity Check Failed"
        else
          echo "Integrity Check Passed"
          echo Starting Mend Scan
          java -jar wss-unified-agent.jar -logLevel debug  # java -jar wss-unified-agent.jar -logLevel debug
        fi
      displayName: 'Mend Unified Agent Security Scan'
      env:
        WS_APIKEY: $(APIKey-Henkel_Prod)
        WS_USERKEY: $(UserKey-MendUnifiedAgentServiceUser_Henkel_Prod)
        WS_WSS_URL: https://saas-eu.whitesourcesoftware.com/agent  # https://saas.mend.io/agent
        WS_PRODUCTNAME: $(System.TeamProject)
        WS_PROJECTNAME: $(Build.Repository.Name)_$(Build.SourceBranchName)
        WS_FILESYSTEMSCAN: false


- stage: Mend Non-Prod Security Scan
  dependsOn: Build
  condition: and(succeeded(), ne(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - job: Mend Non-Prod
    displayName: Mend Non-Prod Az Extension Security Scan Unified Agent Security Scan
    steps:
    - task: Install Package Manger
      displayName: 'Install Package Manger'
        ...
    - task: Install Dependencies
      displayName: 'Install Dependencies'
        ...
    - task: WhiteSource@21
      displayName: 'Mend Az Extension Security Scan'
      inputs:
        cwd: '$(System.DefaultWorkingDirectory)'
        projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
        configuration: |
          fileSystemScan=false


- stage: SonarQube Security Scan
  dependsOn: Build
  jobs:
  - job: SonarQube
    displayName: SonarQube Security Scan
    steps:
     ...


- stage: Netsparker Security Scan
  dependsOn: Build
  jobs:
  - job: Netsparker
    displayName: Netsparker Security Scan
    steps:
     ...


- stage: DeployDev
  displayName: Deploy to dev
  jobs:
  - deployment: Deploy
    displayName: Deploy new Revision to Container App
    environment:
      name: dev
    strategy:
      ...


- stage: DeployTest
  displayName: Deploy to test
  dependsOn:
  - DeployDev
  jobs:
  - deployment: Deploy
    displayName: Deploy new Revision to Container App
    environment:
      name: test
    strategy:
      ...


- stage: DeployProd
  displayName: Deploy to prod
  dependsOn:
  - Mend Prod Security Scan
  - Mend Non-Prod Security Scan
  - DeployTest
  jobs:
  - deployment: Deploy
    displayName: Deploy new Revision to Container App
    environment:
      name: prod
    strategy:
      ...
````






If you are using the Mend Azure Extension task you will be able to see the Mend results in the pipeline run. See picture below.

![Mend report](https://whitesource-resources.s3.amazonaws.com/public-images/security_vulnerabilities_tab.png "whitesource report")






Mend Azure Extension for Java
```yaml
MEND AZURE EXTENSION - FOR MAVEN

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      resolveAllDependencies=false      # <-- Disables all resolvers, SET ONLY if sure which resolvers to activate
      fileSystemScan=false
      html.resolveDependencies=true
      maven.resolveDependencies=true
      maven.ignoreMvnTreeErrors=false
      maven.downloadMissingDependencies=true
```



## Dealing with findings
Please check [here](remediation.md) how to get scan results and fix them. 

The [Common Vulnerability Scoring System (CVSS)](https://www.first.org/cvss/) is an industry standard for evaluating the severity of potential or actual security vulnerabilities in computer systems. In the CVSS, security vulnerabilities are evaluated according to various criteria, so-called metrics, and compared with each other so that a priority list for countermeasures can be created.

1. Install provided WhiteSource fixes (if available).
2. If there are no fixes provided by Mend, install and test carefully the recommended updated version on a new branch.
3. If the CVSS score is *7.5 or higher*, you should update the dependency (if the update is already available) and fix the breaking changes yourself.
4. With a CVSS score lower than 7.5, consider not to update the dependency to keep the application running. Reach out the with Henkel Security Consulting Team for further recommendations.
5. Install the recommended update as soon as it is available.

As per Corporate Standard Cyber Security (Section 8.6.1) following remediation timeframes must be followed:



| **Severity** | **Requirement for remediation**  |
|--|--|
| **Critical vulnerabilities** | (CVSS  base score typically 9-10, i.e., if exploitation could allow code execution without user interaction) must be remediated within 72 hours after detection or following an agreed upon action plan. Ideally, critical vulnerabilities should be remediated within 24 hours after detection. Exceptions require CISO & CDIO approval. |
| **Important vulnerabilities** | (CVSS base score typically 7.0-8.9, i.e., if exploitation could result in compromise of the confidentiality, integrity, or availability of Henkel data, or of the integrity or availability of processing resources) must be remediated within 30 days after detection or following an agreed upon action plan. Exceptions require SOC approval for deviations and CISO approval for risk acceptances. |
| **Moderate vulnerabilities** | (CVSS base score typically 4.0-6.9, i.e., if the impact of the vulnerability is limited, or the likelihood of exploitation is low e.g. due to authentication requirements) must be remediated within 90 days after detection. Exceptions require SOC approval. |
| **Low vulnerabilities**  | (CVSS base score typically 0.1 – 3.9, i.e. if Impact of the vulnerability is comprehensively mitigated by the characteristics of the affected component) must be remediated within 180 days after detection. Exceptions require SOC approval. |

A confirmed existing vulnerability with a CVSS score >= 7.0 is currently being discussed to be a quality gate for security. A vulnerability with that score needs immediate remediation, and pipelines should not allow these vulnerabilities to make it into production.
So prepare for these kind of enforcements early by mitigating vulnerabilities and involve dxS for needed consultation.
