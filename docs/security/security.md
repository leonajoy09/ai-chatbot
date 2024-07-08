# Security

Security is a **shared responsibility**.
While some security measures are managed centrally at dx or through trusted partners, asset owners need to take over some aspects relating to security, too.
This includes managing security issues on code, web and infrastructure level.

Follow our security practices and you are good to go:

## General

* Understand and follow the CSIS (Corporate Standard for Information Security), which is binding for all Henkel employees and contractors.
* Follow the recommendations from the Security assessment (Sec check) process
* Never share credentials such as access keys and token with others
* Always make use of your Henkel ID or your B2B users to access resources where possible
* Within source code, always validate external inputs and verify that it fits your expectations (e.g., length of input or used characters) to avoid e.g. SQL injection attacks.

## Azure

* use key vaults (Azure Key Vault, AWS Secrets Manager)
* use Azure policies to create allow/deny lists for roles, services and users you really need
* use the Azure Security centerto monitor the recommendations
* encrypt everything at rest (using cloud provider managed keys) and in transit (SSL)
* do not expose services unless needed e.g. opening a IP range to the entire internet
* expose services only between receiver and sender and use authentication between microservices
* do not store access keys anywhere including repositories, hard-coded in scripts or on VMs
* shut down/stop instances when not in use to reduce attack surface

### Read Further

- [Azure Security](../security/infrastructure/azure.md)

## Google Cloud Platform

Google Cloud platform Security detaisl aare captured under two articles, see below

### Read Further

- [GCP Security](../cloud/gcp/landing-zone.md)
- [GCP DevSecOps](../cloud/gcp/devsecops.md)

## Cloud Security Remarks

Manipulating the security controls e.g. vnet opening without consent of SOC and NOC **can lead to immediate termination of your workloads**

* every security incident should be reported to SOC and instances immediately to be isolated from further attacks
* ask for help if you feel there is something to improve or check towards security
  
## DevSec 

* do not hard-code credentials in code
* keep your software versions and frameworks up to date, follow their security notifications
* do not expose log messages in your code that could leak environment information
* do not expose the security controls of Henkel anywhere

### Why Inventorization happens

A well-managed inventory provides a central location to track assets and ensure that they're secured effectively. It also fastens the process of vulnerability vemediation.

#### Inventorize Repository: Add alfabet block to README.md (last update 08.01.2024)

For Invetorization of repositories we are using a so called "Alfabet Block". A well maintained Alfabet Block reduces unnecessary workload and meetings. 
It is also important to maintin the Alfabet Block as Status, Public exposure, Owner, etc. might change in future.

* To automate the collection of inventory data (repositories, asset owner, application ID, URLs/APIs), the README.md files are scanned.
* For each repo, please maintain your README.md continuously - in the following format:

![README description full](../../images/README description full.PNG)
```` 
```alfabet
Product: App name
Owner: Owner henkel.com mail address
App-Id: Alfabet EAM App-ID
DEV-URL: DEV-URL1,DEV-URL2,DEV-URL3
QA-URL: QA-URL1,QA-URL2,QA-URL3
PROD-URL: PROD-URL1,PROD-URL2,PROD-URL3
Public exposure: internet-facing OR internal OR not in production
Repo type: documentation OR sourcecode OR logic app OR config
Status: active OR archived OR PoC
```
````

* Separate URLs through a comma, without space
* A filled README.md looks like this in practice:

![README example full](../../images/README example full.PNG)

Definition of different **Public exposure** values:

* internet-facing: accessible through internet directly or indirectly (frontend and backend components)
* internal: only accessible through internal network or accessible only with valid certificate
* not in production: not live

Defintion of different **Repo Type** values:

* documentation: only used for documentation, no code
* sourcecode: containing sourcecode
* logic app: applicaitons developed on a low code platform e.g. Azure Logic Apps
* config: config file 

Definition of different **Status** values:

* active: a repository which is active and in use
* archived: a repository which is disabled in azure or archived
* PoC: a repository which is planned to get disabled and not planned to go online

### How to disable a repository in Azure DevOps 

* To disable a repository, go to "Project Settings", for the selected project. 
* Under the "Project Settings", select "Repositories".
* Pick a repository and navigate to "Settings" for that repository.
* Under the "Settings", you will find the option “Disable Repository” – Turn it on.

![disable repository](../../images/disable repository.PNG)

* Once the repository is disabled, if you try to access the repository, including build, pull request, branch, or files, you will have a message that indicates the repository is disabled.

