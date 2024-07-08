## Maven Best Practices

Follow [this](https://docs.henkelgroup.cloud/security/DevSecOps/sonarqube-sub/onboard-sq/) documentation if you want to onboard your Project to SonarQube, including information about the parameter and a detailed documentation from SonarQube.

Below you can find an example Pipeline Task for Maven.

```yaml
# Maven
# Build your Java project and run tests with Apache Maven.
# Add steps that analyze code, save build artifacts, deploy, and more:
# https://docs.microsoft.com/azure/devops/pipelines/languages/java

trigger:
- content_adding

pool:
  vmImage: ubuntu-latest
steps:  

- task: SonarQubePrepare@5
  inputs:
    SonarQube: 'YourSonarqubeServerEndpoint'
    scannerMode: 'Other'
    extraProperties: |
      # Additional properties that will be passed to the scanner,
      # Put one key=value per line, example:
      # sonar.exclusions=**/*.bin
      sonar.projectKey=$(Build.Repository.Name)

- task: JavaToolInstaller@0
  inputs:
    versionSpec: '11'
    jdkArchitectureOption: 'x64'
    jdkSourceOption: 'PreInstalled'

- task: Maven@3
  inputs:
    mavenPomFile: '/home/vsts/work/1/s/java/pom.xml'
    publishJUnitResults: true
    testResultsFiles: '**/surefire-reports/TEST-*.xml'
    javaHomeOption: 'JDKVersion'
    mavenVersionOption: 'Default'
    mavenAuthenticateFeed: false
    effectivePomSkip: false
    sonarQubeRunAnalysis: true
    sqMavenPluginVersionChoice: 'latest'

- task: SonarQubePublish@5
  inputs:
    pollingTimeoutSec: '300'
```