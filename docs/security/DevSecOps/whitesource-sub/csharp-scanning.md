## C# Scanning Best Practices
[Mend Documentation: C# Scanning Best Practices](https://docs.mend.io/bundle/unified_agent/page/nuget_integration.html)

```yaml
MEND UNIFIED AGENT (Linux) - FOR NUGET based on package references in package files:

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
    WS_APIKEY: $(OrgKey-Henkel_Dev)
    WS_USERKEY: $(UserKey-ServiceUser_Henkel_Dev)
    WS_WSS_URL: https://saas-eu.whitesourcesoftware.com/agent  
    WS_PRODUCTNAME: # Set your entry from the linked list below!
    WS_PROJECTNAME: $(Build.Repository.Name)_$(Build.SourceBranchName)
    WS_FILESYSTEMSCAN: false
    WS_RESOLVEALLDEPENDENCIES: false     
    WS_HTML_RESOLVEDEPENDENCIES: true
    WS_NUGET_RESOLVEPACKAGESCONFIGFILES: false
    WS_NUGET_RESOLVECSPROJFILES: true
    WS_NUGET_RESOLVEASSETSFILES: true
```
```yaml
MEND UNIFIED AGENT (Linux) - FOR NUGET based on packages.config:

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
    WS_APIKEY: $(OrgKey-Henkel_Dev)
    WS_USERKEY: $(UserKey-ServiceUser_Henkel_Dev)
    WS_WSS_URL: https://saas-eu.whitesourcesoftware.com/agent  
    WS_PRODUCTNAME: # Set your entry from the linked list below!
    WS_PROJECTNAME: $(Build.Repository.Name)_$(Build.SourceBranchName)
    WS_FILESYSTEMSCAN: false
    WS_RESOLVEALLDEPENDENCIES: false     
    WS_HTML_RESOLVEDEPENDENCIES: true
    WS_NUGET_RESOLVEPACKAGESCONFIGFILES: true
    WS_NUGET_RESOLVECSPROJFILES: true
    WS_NUGET_RESOLVEASSETSFILES: false
```

**Select the respective entry for WS_PRODUCTNAME that fits your team from** [Page: "WS_PRODUCTNAME Entry"](./ws-productname-setup.md). 


### Configuration comments

- For both package manager formats, please set the nuget.runPreStep to true if the project is not built prior to the scan.
- For projects based on package references in package files (PackageReference), the following flags setup is recommended:
  ```yaml
  nuget.resolvePackagesConfigFiles=false
  nuget.resolveCsProjFiles=true
  nuget.resolveAssetsFiles=true
  ```
- For projects based on packages.config, the following flags setup is recommended:
NOTE: It is highly recommended to use NuGet version 4.9 or higher in this case, as the Unified Agent will be able to generate the corresponding packages.lock.json file for better resolution.
  ```yaml
  nuget.resolvePackagesConfigFiles=true
  nuget.resolveCsProjFiles=true
  nuget.resolveAssetsFiles=false
  ```




