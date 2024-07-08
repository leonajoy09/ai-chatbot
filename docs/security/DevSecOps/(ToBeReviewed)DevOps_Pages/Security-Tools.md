# **Security Tools**

## Sonarqube

**SonarQube** is a platform for continuous inspection of code quality to detect bugs, code smells, and security vulnerabilities. With its tight coupling to Azure Pipelines, SonarQube analyzes our projects and provides code health metrics at the right time and in the right place.

### Project configuration with SonarQube: 

- SonarQube basic information
- Enterprise application for SonarQube in Azure
- AAD groups for SonarQube in Azure
- Configuring SAML authentication with Azure Active Directory
- Process to request access to SonarQube
- Process to create AAD group in Azure
- Process to create groups in SonarQube
- Process to create projects and related project account in SonarQube
- Permission control for SonarQube projects
- Tokens for project account in SonarQube
- Integrations of SonarQube with Azure Pipelines
- Service connections in Azure DevOps

### SONARQUBE integration with azure

![image-20220421175445023](../attachments/image-20220421175445023.png)

#### Add SonarQube into Azure DevOps Pipeline

```yaml
- task: SonarQubePrepare@4
  inputs:
    SonarQube: $(ProjectName)
    scannerMode: 'CLI'
    configMode: 'manual'
    cliProjectKey: $(Build.Repository.Name)
  displayName: 'prepare sonarqube scan'
- task: SonarQubeAnalyze@4
  displayName: 'run sonar analyzer'
- task: SonarQubePublish@4
  inputs:
    pollingTimeoutSec: '300'
  displayName: 'publish to sonar instance'

```



## WhiteSource

**WhiteSource** can integrate with development environments and DevOps pipeline to detect open-source libraries, licenses with security or compliance issues in real-time. 

### Project configuration with WhiteSource:

- Configuring Project Settings
- Integrate WhiteSource with Azure Pipelines

![image-20220421175356970](../attachments/image-20220421175356970.png)

### Add WhiteSource into Azure DevOps Pipeline

```yaml
- task: WhiteSource@21
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: '$(Build.Repository.Name)'
```



## Netsparker

**Netsparker** is an automated, yet fully configurable, web application security scanner that enables you to scan all types of web applications, regardless of the platform or the language with which they are built. It is the only online web application security scanner that automatically exploits identified vulnerabilities in a read-only and safe way, in order to confirm identified issues. 

![image-20220421175423665](../attachments/image-20220421175423665.png)



### Add Netsparker into Azure DevOps Pipeline

```yaml
- task: netsparker-cloud@1
  displayName: 'DAST - Netsparker Scan'
  inputs:
    apiConnection: 'Netsparker'
    scanTypes: '2'
    scanWebSites: $(NetSparkerscanWebSites)
    scanWebSitesProfile: $(NetSparkerscanWebSitesProfile)
    hasReport: true
    reportType: 'OwaspTopTen2017'
```

