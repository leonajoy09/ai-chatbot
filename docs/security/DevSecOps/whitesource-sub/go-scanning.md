## Go Scanning Best Practices

[Mend Documentation: Go Scanning Best Practices](https://docs.mend.io/bundle/wsk/page/configuring_the_unified_agent_for_go.html)
[Mend Documentation: Go Scanning Best Practices II](https://docs.mend.io/bundle/unified_agent/page/go_integration.html#Using-the-go.collectDependenciesAtRuntime-parameter)


```yaml
MEND UNIFIED AGENT (Linux) - FOR GODEP based on the Gopkg.lock file:

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
    WS_GO_RESOLVEDEPENDENCIES: true
    WS_GO_MODULES_RESOLVEDEPENDENCIES: true
    WS_GO_COLLECTDEPENDENCIESATRUNTIME: false
    WS_GO_DEPENDENCYMANAGER: godep
```

**Select the respective entry for WS_PRODUCTNAME that fits your team from** [Page: "WS_PRODUCTNAME Entry"](./ws-productname-setup.md). 





### Configuration comments

- **Before scanning a Go project, ensure the following for the most accurate results:**
  - You are using a supported Go package manager: glide, gopm, godep, dep, govendor, vndr, modules (Go Modules)
  - **The project dependencies are installed on the machine where you are running the scan.**
  - One of the following is true:
    - The dependency file and 'vendor' folder are available in the project, OR
    - The ```go.collectDependenciesAtRuntime``` configuration parameter is set to true and the relevant dependency manager is installed.
  - Additionally, when using Go Modules, ensure that:
    1) The environment variable ```GO111MODULE``` is set appropriately. When your project folder is under the GOPATH, make sure to set ```GO111MODULE=on```.
    2) You have a 'go.mod' or 'modules.txt' file as well as the source code for your project.
    3) ```go.resolveDependencies=false``` and ```go.modules.resolveDependencies=true``` in your UA config file.

- For all Go package managers other than Modules:
  ```yaml
  go.resolveDependencies=true
  go.dependencyManager=<PackageManager You Use>
  ```
  - Note: if your team uses more than one package manager for Go, you can leave go.dependencyManager unmodified. In this case, the default behavior is to attempt dependency resolution with each supported Go package manager. To improve the efficiency of your scan, set this parameter to the specific package manager you are using for your Go projects.
- Optional parameters:
  - ```go.collectDependenciesAtRuntime``` Set to true if your project does not already have a 'vendor' folder. Make sure to run govendor fetch on the relevant project to download its dependencies first, otherwise the Unified Agent will return direct and transitive dependencies as a flat structure.
  - ```go.ignoreSourceFiles``` Set to true if you wish to only include package dependencies, not source files. When set to true go source files will be ignored in the scan.
  - ```go.glide.ignoreTestPackages``` Set to true if you wish to ignore test packages defined in the 'testImport' section of the 'glide.yaml' file.
  - ```go.gogradle.enableTaskAlias``` Set to true when using gogradle dependency manager and the gradle argument (in 'gradle.properties') includes gogradle.alias=true.

- Go Modules Specific Parameters (see webpages from the top)

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
