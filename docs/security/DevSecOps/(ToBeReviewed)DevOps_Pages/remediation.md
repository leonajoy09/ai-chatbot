## 2. DevSecOps Tech + Process Overview

Below chart explains the security testing set-up in CICD pipelines, at which stage a security scan is being performed and whom to address for different kinds of findings. It must be part of the general "Definition of Done", that results of security scanning are verified after every code commit.

While SAST and SCA are targeting code that is being created and build in the CI phase, DAST is running against a deployed application or API, preferably on a staging environment (one step before release on prod).

![Remediation](../../images/remediationew.JPG)

Findings that are detected in the CI stage should be addressed to the developers (e.g. to update an outdated open source dependency). 
For scans within the CD stage, results have to be reviewed first. Either findings relate to flaws in the development phase (e.g. outdated webserver, no input validation of user input on the front end), or they relate to runtime issues (e.g. app cracks down under pressure, information disclosure on memories, ...). Findings should then be addressed to developers or operators, respectively.

Below image visualizes how parts of the remediation actually look like:

![Visuals](../../images/Remediation process visuals.JPG)

After code snippets for SCA and DAST were integrated into respective pipeline YAMLs, and pipelines were triggered, results are put into Azure DevOps (as ticket or a visual report). The real findings are reviewed by the team and PO, and become a PBI in one of the next sprints.
Findings are fixed during the sprint and are re-scanned once the pipeline is triggered again.

## 3. SAST remediation process

tbd, dxT responsible for Code Quality and SAST via SonarQube

## 4. SCA remediation process

### 4.1 Getting scan results
Once WhiteSource is integrated into applicable pipeline.yaml files of an Azure DevOps project, scan results are automatically visualized in the results tabs of the specific pipeline (WhiteSource -> Security vulnerabilities):

![WhiteSource](../../images/whitesourceadoresult.png)

This is a user friendly way for developers to consume WhiteSource findings. To get more context and to drill down into specific findings (e.g. to get more remediation information) the respective web dashboard of the tool can be used. Links are provided in invitation e-mails after access has been requested via MyID (search for WhiteSource and Netsparker groups).

Findings are then reviewed and put into a backlog item by the product owners. In following project sprints (scheduled according to severity) the findings are then being remediated and being worked on by the team.

Alternative ways to cope with the findings are:

- Sending issues to Azure DevOps Board (might lead to flooding of tasks and items)
- dxS Consultant to inform project about findings (via ppt, screenshots through mail or chat)


### 4.2 Remediation:
Remediation then involves the following steps:

1. Get an overview and check if there are critical / high findings that need immediate attention.
2. Continue to check and verify if there are false-positives: Is the dependency really used in the project, or even exposed at any step in the application logic?
If multiple devdependencies create a lot of noise, several tasks can be used to reduce the number of false-positives ([Link](https://dev.azure.com/henkeldx/RAQN%20Security/_wiki/wikis/RAQN-Security.wiki/7876/WhiteSource-integration-configuration-guideline?anchor=2.2-configuration-for-different-tech-stacks))
To suppress generated findings mark the alert, chose "ignore", add your reason.
3.  Prioritize and pick up the most critical one's to fix first.
4. Discuss with your project lead / product owner. Fixing issues need to be planned, checked for its impact on operations and signed off by  the lead.
5. Apply remediation strategies: Eliminate the finding completely OR mitigate the risk by adding security measures around the finding
In case of false-positive, suppress the finding in WhiteSource SaaS and add argumentation why in the ticket
6. Await re-scan result to confirm that remediation was successful

## 5. DAST remediation process

### 5.1 Getting scan results

Once Netsparker is integrated into a suitable pipeline.yaml file of an Azure DevOps project, scan results are automatically visualized in the respective results tabs of that pipeline ("Invicti Enterprise Scan Report"):

![Netsparker](../../images/netsparkeradoresult.png)

This is a user friendly way for developers to consume Netsparker findings. To get more context and to drill down into specific findings (e.g. to get more remediation information) the respective web dashboard of the tool can be used. Links are provided in invitation e-mails after access has been requested via MyID (search for WhiteSource and Netsparker groups).

These findings are then put into a backlog item to be picked up in project sprints (scheduled according to severity).
Report types can be adjusted according to project needs, it is recommended to go with 'ScanDetail" as output task.

Alternative ways are:

- Sending issues to Azure DevOps Board, once issue is fixed in DevOps automatic re-scan of that increment takes place ([Link](https://www.invicti.com/support/integrating-invicti-enterprise-azure-boards/))
- dxS Consultant to inform project about findings (via ppt, screenshots through mail or chat)
- Project to receive MS Teams notifications for scan results (ChatOps) ([Link](https://www.invicti.com/support/integrating-invicti-enterprise-microsoft-teams/))

### 5.2 Remediation:
Remediation then involves the following steps:

1. Get an overview and check if there are critical / high findings that need immediate attention.
2. False-Positive check: Verify if the vulnerability can be actually exploited, you can consult dxS in case of doubts or if an advanced testing technique shall verify on exploitability. Issues can marked as false-positive by selecting the issue, "edit", and clicking "false-positive". Information and argumentation then has to be provided why the finding is being marked.
3. Discuss with your project lead / product owner. Fixing issues need to be planned, checked for its impact on operations and signed off by  the lead.
4. Apply remediation strategies: Eliminate the finding by applying the recommended remediation OR mitigate the risk by adding security measures around the finding.In case of false-positive, suppress the finding in Netsparker SaaS and add argumentation why in the ticket
6. Await re-scan result to confirm that remediation was successful