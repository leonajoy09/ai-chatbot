## Gradle Best Practices

Follow [this](https://docs.henkelgroup.cloud/security/DevSecOps/sonarqube-sub/onboard-sq/) documentation if you want to onboard your Project to SonarQube, including information about the parameter and a detailed documentation from SonarQube.

Below you can find an example Pipeline Task for Gradle.

```yaml
# Starter pipeline
# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

trigger:
- master

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
      #sonar.projectKey=YourProjectKeyProvidedBySonarQube
      sonar.projectKey=$(Build.Repository.Name)

- task: JavaToolInstaller@0
  inputs:
    versionSpec: '11'
    jdkArchitectureOption: 'x64'
    jdkSourceOption: 'PreInstalled'

- task: Gradle@3
  inputs:
    gradleWrapperFile: 'gradlew'
    tasks: 'build'
    publishJUnitResults: true
    testResultsFiles: '**/TEST-*.xml'
    javaHomeOption: 'JDKVersion'
    sonarQubeRunAnalysis: true
    sqGradlePluginVersionChoice: 'specify'
    sonarQubeGradlePluginVersion: '2.6.1'
    spotBugsAnalysis: false

- task: SonarQubePublish@5
  inputs:
    pollingTimeoutSec: '300'
```