## Azure DevOps Extension
The Mend / WhiteSource extension is installed in the Henkel AzureDevops environment and can be added to
the azure pipeline using the following code:

```yaml
- task: WhiteSource@21
  displayName: 'WhiteSource Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)
```
To adding a breakpoint in the pipeline to make the build fail you can config the policies check, which is to check the policies that we defined on the WhiteSource which are as follows: 
- Critical vulnerabilituies (CVE score dfrom 7.5 to 10)
- Block GPL (GPL based libraries and derivatives of GPL) 
To have ploicy check we should use the following code.

```yaml
- task: WhiteSource@21
  displayName: 'WhiteSource Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)
    configuration: |
            checkPolicies=true
```

After the pipeline run you can find the report in pipeline menu. 
Select the pipeline and the pipeline run. You should see a menu 
item labed *Mend*

![Mend report](https://whitesource-resources.s3.amazonaws.com/public-images/security_vulnerabilities_tab.png "whitesource report")


## CSHARP

```yaml
MEND AZURE EXTENSION - FOR NUGET based on package references in package files 

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      fileSystemScan=false
      html.resolveDependencies=true
      nuget.resolvePackagesConfigFiles=false
      nuget.resolveCsProjFiles=true
      nuget.resolveAssetsFiles=true
```

```yaml
MEND AZURE EXTENSION - FOR NUGET based on packages.config

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      fileSystemScan=false
      html.resolveDependencies=true
      nuget.resolvePackagesConfigFiles=true
      nuget.resolveCsProjFiles=true
      nuget.resolveAssetsFiles=false
```

## Go

```yaml
MEND AZURE EXTENSION - FOR GODEP based on the Gopkg.lock file

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      resolveAllDependencies=false      # <-- Disables all resolvers, SET ONLY if sure which resolvers to activate
      fileSystemScan=false
      html.resolveDependencies=true
      go.modules.resolveDependencies=true
      go.resolveDependencies=true   
      go.collectDependenciesAtRuntime=false
      go.dependencyManager=godep
```

```yaml
MEND AZURE EXTENSION - FOR GLIDE based on the glide.yaml file

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      html.resolveDependencies=true
      go.modules.resolveDependencies=true
      go.resolveDependencies=true   
      go.dependencyManager=glide
      go.glide.ignoreTestPackages=false
```

## iOS

```yaml
MEND AZURE EXTENSION - FOR COCOAPODS

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      includes=**/*.m **/*.mm **/*.js **/*.php
      cocoapods.resolveDependencies=true
      cocoapods.ignoreSourceFiles=true
```

## javascript


```yaml
MEND AZURE EXTENSION - FOR NPM

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      resolveAllDependencies=false      # <-- Disables all resolvers, SET ONLY if sure which resolvers to activate
      fileSystemScan=false
      html.resolveDependencies=true
      npm.resolveDependencies=true
      npm.ignoreSourceFiles=true
      npm.resolveLockFile=true
```

## PHP


```yaml
MEND AZURE EXTENSION - FOR PHP

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      resolveAllDependencies=false      # <-- Disables all resolvers, SET ONLY if sure which resolvers to activate
      fileSystemScan=false
      html.resolveDependencies=true      
      php.resolveDependencies=true
```

## Python


```yaml
MEND AZURE EXTENSION - FOR PIP

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      resolveAllDependencies=false      # <-- Disables all resolvers, SET ONLY if sure which resolvers to activate
      fileSystemScan=false
      html.resolveDependencies=true
      python.resolveDependencies=true
      python.installVirtualenv=true
      python.resolveHierarchyTree=true
      python.ignorePipInstallErrors=false
      python.resolvePipEditablePackages=true
```

## Ruby



```yaml
MEND AZURE EXTENSION - FOR Ruby

- task: WhiteSource@21
  displayName: 'Mend Az Extension Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)_$(Build.SourceBranchName)
    configuration: |
      resolveAllDependencies=false      # <-- Disables all resolvers, SET ONLY if sure which resolvers to activate
      fileSystemScan=false
      html.resolveDependencies=true      
      ruby.resolveDependencies=true
```