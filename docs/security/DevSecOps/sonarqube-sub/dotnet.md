## .NET Best Practices

Follow [this](https://docs.henkelgroup.cloud/security/DevSecOps/sonarqube-sub/onboard-sq/) documentation if you want to onboard your Project to SonarQube, including information about the parameter and a detailed documentation from SonarQube.

Below you can find an example Pipeline Task for .NET.

```yaml
# ASP.NET Core
# Build and test ASP.NET Core projects targeting .NET Core.
# Add steps that run tests, create a NuGet package, deploy, and more:
# https://docs.microsoft.com/azure/devops/pipelines/languages/dotnet-core

trigger:
- main # or the name of your main branch
- feature/*

pool:
  vmImage: ubuntu-latest

steps:
# Prepare Analysis Configuration task
- task: SonarQubePrepare@5
  inputs:
    SonarQube: 'YourSonarqubeServerEndpoint'
    scannerMode: 'MSBuild'
    projectKey: '$(Build.Repository.Name)'
    #projectKey: 'YourProjectKeyProvidedBySonarQube'

# Dotnet build(?) task - automatically created by azure
# - script: dotnet build --configuration $(buildConfiguration)
#   displayName: 'dotnet build $(buildConfiguration)'

# Dotnet build task
- task: DotNetCoreCLI@2
  displayName: 'dotnet build'

# Run Code Analysis task
- task: SonarQubeAnalyze@5

# Publish Quality Gate Result task
- task: SonarQubePublish@5
  inputs:
    pollingTimeoutSec: '300'
```