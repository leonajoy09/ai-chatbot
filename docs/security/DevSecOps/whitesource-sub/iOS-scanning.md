## iOS Scanning Best Practices

[Mend Documentation: iOS Scanning Best Practices](https://docs.mend.io/bundle/wsk/page/configuring_the_unified_agent_for_ios_projects__cocoapods_.html)

```yaml
MEND UNIFIED AGENT (macOS) - FOR COCOAPODS

- script: |
    echo Downloading Mend Unified Agent
    curl -LJO https://unified-agent.s3.amazonaws.com/wss-unified-agent.jar
    if [[ "$(curl -sL https://unified-agent.s3.amazonaws.com/wss-unified-agent.jar.sha256)" != "$(shasum -a 256 wss-unified-agent.jar)" ]] ; then
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
    WS_INCLUDES: '**/*.m **/*.mm **/*.js **/*.php'
    WS_COCOAPODS_RESOLVEDEPENDENCIES: true
    WS_COCOAPODS_IGNORESOURCEFILES: true
    WS_RUBY_INSTALLMISSINGGEMS: true
    WS_RUBY_RUNBUNDLEINSTALL: true
```

```yaml
MEND UNIFIED AGENT (Linux) - FOR COCOAPODS

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
    WS_INCLUDES: '**/*.m **/*.mm **/*.js **/*.php'
    WS_COCOAPODS_RESOLVEDEPENDENCIES: true
    WS_COCOAPODS_IGNORESOURCEFILES: true
    WS_RUBY_INSTALLMISSINGGEMS: true
    WS_RUBY_RUNBUNDLEINSTALL: true
```

**Select the respective entry for WS_PRODUCTNAME that fits your team from** [Page: "WS_PRODUCTNAME Entry"](./ws-productname-setup.md). 


#### Pipeline Task - Several Programming Languages or Problems with Language Specific Task
If you have several programming languages that need to be scanned in a repository or any problems while executing the language specific Mend task, try the default Mend task with all resolvers enabled and please engage with devsecops@henkel.com to help craft a specifig task for the repository.
 
```yaml
MEND UNIFIED AGENT (Linux) - DEFAULT ALL RESOLVERS & NO FILESYSTEMSCAN:

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
    WS_PRODUCTNAME: # Set your entry from the list in the top!
    WS_PROJECTNAME: $(Build.Repository.Name)_$(Build.SourceBranchName)
    WS_FILESYSTEMSCAN: false
```



