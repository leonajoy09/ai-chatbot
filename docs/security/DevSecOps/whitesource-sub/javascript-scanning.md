## JavaScript Scanning Best Practices

[Mend Documentation: JavaScript Scanning Best Practices](https://docs.mend.io/bundle/wsk/page/javascript_best_practice_scanning.html)

```yaml
MEND UNIFIED AGENT - FOR NPM

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
    WS_NPM_RESOLVEDEPENDENCIES: true
    WS_NPM_IGNORESOURCEFILES: true
    WS_NPM_RESOLVELOCKFILE: true
```

**Select the respective entry for WS_PRODUCTNAME that fits your team from** [Page: "WS_PRODUCTNAME Entry"](./ws-productname-setup.md). 








### Configuration comments

  - For JavaScript 3 Resolvers available: NPM, YARN and HTML
  - NPM
    - **before running Mend it is required to install dependencies via npm install (this will download your dependencies and generate the node_modules folder and the package-lock.json file)**
      - can also be run by Mend with "npm.runPrestep=true"
    - Upon completion of the step above, you should have the following folder structure:
    ```yaml
    /scan/directory/package.json
    /scan/directory/package-lock.json
    /scan/directory/node_modules/
    ```
    - Recommended Way: by parsing package.json and package-lock.json and not looking into node_modules folder
      - improves scanning time + produces more accurate results    
    ```yaml
    npm.resolveDependencies=true (default)
    npm.ignoreSourceFiles=true (default)
    npm.resolveLockFile=true (default)
    ```
    - second Approach: using "npm ls" requiring package.json and node_modules but not package-lock.json [see webpage](https://docs.mend.io/bundle/wsk/page/javascript_best_practice_scanning.html)
  - YARN: for Yarn Package Manager [see webpage](https://docs.mend.io/bundle/wsk/page/javascript_best_practice_scanning.html)
  - HTML: can be used to resolve JavaScript source files that are used by src attribute in HTML files [see webpage](https://docs.mend.io/bundle/wsk/page/javascript_best_practice_scanning.html)

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

##  Mend Prioritize
Mend Prioritize is a feature that can be activated via config parameters in order to:

- Asses the presence of a vulnerability: Analyzes for each vulnerability whether the vulnerable function of the vulnerale library is called by your code. 
- Identify file and line number of the call: Mend provides a call trace. 

This allows Mend to flag the presence of a vulnerablity according to the following categories:

![MendPrioritizeCategories](../../../images/Mend Prioritize Categories.PNG)

More information on: [Mend Prioritize](https://docs.mend.io/bundle/sca_user_guide/page/mend_prioritize.html).

### JavaScript Scanning Best Practices (with Mend Prioritize)

The following sections will provide the Mend tasks. Supported languages can be found [here](https://docs.mend.io/bundle/sca_user_guide/page/scanning_projects_with_mend_prioritize.html).


#### Pipeline Task - JavaScript:
```yaml
MEND UNIFIED AGENT (Linux) - FOR NPM

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
    WS_RESOLVEALLDEPENDENCIES: false
    WS_ENABLEIMPACTANALYSIS: true
    WS_HTML_RESOLVEDEPENDENCIES: true
    WS_NPM_RESOLVEDEPENDENCIES: true
    WS_APPPATH: /home/vsts/work/1/s/package.json
    WS_D: /home/vsts/work/1/s
```
Set the "apppath" parameter approppriatly to point to the build Javascript application.
