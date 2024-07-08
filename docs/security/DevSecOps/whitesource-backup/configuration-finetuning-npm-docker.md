## Configuration
You can configure the scan using the [configuration parameters](https://whitesource.atlassian.net/wiki/spaces/WD/pages/1544880156/Unified+Agent+Configuration+Parameters).

Configuration parameters can be provided using the Mend task in the pipeline or as configuration file in the repository.

For example, if we want to scan a NodeJS application we should turn on some configurations from this page . So, a scan on a NodeJS application would look like this:
```yaml
- task: WhiteSource@21
  displayName: 'WhiteSource Security Scan'
  inputs:
    cwd: '$(System.DefaultWorkingDirectory)'
    projectName: $(Build.Repository.Name)
    configuration: |
      fileSystemScan=False
      npm.includeDevDependencies=False
      npm.removeDuplicateDependencies=True
```

### Fine-Tuning

Configurations for further technologies can be found below:

To fine tune Mend for [python projects](https://whitesource.atlassian.net/wiki/spaces/WD/pages/1544880156/Unified+Agent+Configuration+Parameters#Python).

To cover Swift (iOS), please refer to the [CocoaPods section](https://whitesource.atlassian.net/wiki/spaces/WD/pages/1544880156/Unified+Agent+Configuration+Parameters#Objective-C,-Swift).

To scan for vulnerable docker dependencies in docker images: [Docker Image Integration](https://whitesource.atlassian.net/wiki/spaces/WD/pages/1544880156/Unified+Agent+Configuration+Parameters#Docker-Images)

### NPM
When Mend identifies a `package.json` file, it tries to determine whether it is an NPM or a yarn project based on the relevant lock file. 
If `yarn.lock` is identified, the yarn resolution is performed. In addition, if the `npm.runPreStep` is set, the `yarn install` is executed.
If `package-lock.json` is identified, the NPM resolution is performed. In addition, if the `npm.runPreStep` is set, then `npm install` is executed.

Only if both lock files are found or missing, the Unified Agent will use the npm.yarnProject parameter to determine which pre-step and/or resolution to perform.

### Docker
For Docker please refer the [Docker Image](https://whitesource.atlassian.net/wiki/spaces/WD/pages/710673221/Docker+Image+Integration) or [Docker Container](https://whitesource.atlassian.net/wiki/spaces/WD/pages/1466859822/Docker+Containers+Integration) documentation of WhiteSource.

