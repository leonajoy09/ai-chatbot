## Python Scanning Best Practices

[Mend Documentation: Python Scanning Best Practices](https://docs.mend.io/bundle/wsk/page/configuring_the_unified_agent_for_python.html)

```yaml
MEND UNIFIED AGENT (Linux) - FOR PIP:

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
    WS_PYTHON_RESOLVEDEPENDENCIES: true
    WS_PYTHON_INSTALLVIRTUALENV: true
    WS_PYTHON_RESOLVEHIERARCHYTREE: true
    WS_PYTHON_IGNOREPIPINSTALLERRORS: false
    WS_PYTHON_RESOLVEPIPEDITABLEPACKAGES: true
```

**Select the respective entry for WS_PRODUCTNAME that fits your team from** [Page: "WS_PRODUCTNAME Entry"](./ws-productname-setup.md). 






### Configuration comments

- **Before scanning a Python project, ensure:**
  - You are using supported Pyhton package: Pip, Pipenv, Poetry
  - Python and the package manager you use installed
  - **Dependencies are installed successfully with the package manager on the machine where you are running the scan**
  - project includes one of the following supported file types: requirements.txt, pipfile.toml, setup.py, setup.cfg (starting in Unified Agent v22.5.1), pyproject.toml, environment.yml, Conda
- Configuring Unified Agent Parameters
  - For all scan set:
    ```yaml
    python.resolveDependencies=true
    ```
  - If source files should be included set: ```python.ignoreSourceFiles=false```
- Additional Params for Pip
    ```yaml
    python.installVirtualenv=true
    python.resolveHierarchyTree=true
    python.ignorePipInstallErrors=false
    python.resolvePipEditablePackages=true
    ```
 - If multiple Python versions are installed on the machine, set the following:
    ```yaml
    python.path=<path to Python executable>
    python.pipPath=<pip or pip3>
    ```
   - If the project includes dependencies from an Index other than Pypi, set the following: ```python.indexUrl=<the URL of the index>```
   - If the project uses a file other than requirements.txt and should use Pip to resolve the dependencies, set the following: ```python.requirementsFileIncludes=<name of the file to scan>```
   - If the project includes a setup.cfg (starting in Unified Agent v22.5.1) or setup.py file, set the following to ‘true’: Starting in Unified Agent v22.5.1: ```python.resolveSetupFiles=true```
   - If the project includes local packages set the following: ```python.localPackagePathsToInstall=<path to local packages>```
   - If the project includes global packages set the following to ‘true’: ``` python.resolveGlobalPackages=true```
- Additional Params for Pipenv [here](https://docs.mend.io/bundle/wsk/page/configuring_the_unified_agent_for_python.html)
- Additional Params for Poetry [here](https://docs.mend.io/bundle/wsk/page/configuring_the_unified_agent_for_python.html)
- Additional Params for Conda [here](https://docs.mend.io/bundle/wsk/page/configuring_the_unified_agent_for_python.html)

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

### Python Scanning Best Practices (with Mend Prioritize)

The following sections will provide the Mend tasks. Supported languages can be found [here](https://docs.mend.io/bundle/sca_user_guide/page/scanning_projects_with_mend_prioritize.html).


#### Pipeline Task - Python:
```yaml
MEND UNIFIED AGENT (Linux) - FOR PIP

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
    WS_PYTHON_RESOLVEDEPENDENCIES: true
    WS_APPPATH: /home/vsts/work/1/s/requirements.txt
    WS_D: /home/vsts/work/1/s
```
either Requirements.txt or setup.py needs to be used in appPath
