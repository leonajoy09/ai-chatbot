# Mend Integration for Non-Production Branches - via Mend Unified Agent in Pipeline Integration

**MUST REQUIREMENTS: For Mend to work properly it is required to install the respective package manager in the pipeline and execute a dependency install or build** (e.g in case of npm “npm install”) before running Mend in the pipeline **(We recommend just copy the build step from you buld pipeline or place Mend task after the build step)**. 
If not installing the dependencies with the package manager, the results may not be correct and may not find all vulnerabilities! We recommend executing the Mend task as part of your regular pipelines.

The following steps has to be done to integrate Mend with all non-production branches via the Mend Unified Agent integration in a pipeline:

- **(1) Add Variable Group**: Add the variable group "Mend_Secrets" to the pipeline a) in the beginning part of the yaml file (see below) or b) via connecting the pipeline with the variable group in the trigger settings of the pipeline
````yaml
  variables:
   - group: Mend_Secrets
````

- **(2) Add Mend Task to Pipeline**: Add the Mend tasks to the pipeline with the correct value for "WS_PRODUCTNAME" and **after the package manager installed the dependencies or made a build**. Predefined Mend pipeline tasks per programming lanugage can be find in the below links.
  -	[Java Integration Best Practices](java-scanning.md)
  -	[Javascript Integration Best Practices](javascript-scanning.md)
  -	[Python Integration Best Practices](python-scanning.md)
  -	[GO Integration Best Practices](go-scanning.md)
  -	[C# Integration Best Practices](csharp-scanning.md)
  -	[PHP Integration Best Practices](php-scanning.md)
  -	[Ruby Integration Best Practices](ruby-scanning.md)
  -	[iOS Integration Best Practices](iOS-scanning.md)


### Example Pipeline and Pipeline Integration

- **IMPORTANT: The Mend tasks in the example pipeline require to be adapted to the respective programming language of the application. Therefore, please follow the sub-pages for the different programming languages.**
-	It is possible to run the Mend scan in parallel to the deployment to Dev environment and the Build if the dependencies are installed before or during the job of the Mend scan.
- **IMPORTANT:** Before running Mend each Job installs the respective package manager and at least installs the dependencies with the package manager

Below you will find an example pipeline:

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


- stage: Mend Security Scan
#  condition: and(succeeded(), ne(variables['Build.SourceBranch'], 'refs/heads/main'))   # not necessarily required
  jobs:
  - job: Mend
    displayName: Mend Unified Agent Security Scan
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
      displayName: 'Mend Unified Agent Security Scan (Linux)'
      env:
        WS_APIKEY: $(OrgKey-Henkel_Dev)
        WS_USERKEY: $(UserKey-ServiceUser_Henkel_Dev)
        WS_WSS_URL: https://saas-eu.whitesourcesoftware.com/agent
        WS_PRODUCTNAME: # See prepared tasks under the programming languages for this parameter
        WS_PROJECTNAME: $(Build.Repository.Name)_$(Build.SourceBranchName)
        WS_FILESYSTEMSCAN: false


- stage: SonarQube Security Scan
  jobs:
  - job: SonarQube
    displayName: SonarQube Security Scan
    steps:
     ...


- stage: Netsparker Security Scan
  jobs:
  - job: Netsparker
    displayName: Netsparker Security Scan
    steps:
     ...


- stage: DeployDev
  displayName: Deploy to dev
  dependsOn: build
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
  - Mend Security Scan
  - DeployTest
  jobs:
  - deployment: Deploy
    displayName: Deploy new Revision to Container App
    environment:
      name: prod
    strategy:
      ...
````