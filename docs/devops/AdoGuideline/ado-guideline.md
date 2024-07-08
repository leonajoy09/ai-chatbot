# **Azure DevOps Guideline (dx)**

---


|Azure DevOps Guideline (dx)|
|---------------------------|
|Version 1.4, 5th November 2023|
|Authors:                   |
|  - DevOps Team                |
|  - Digital Factory Shanghai Team|
|  - Cyber Security Consulting & Standards Team|


[[_TOC_]]
# Contents

[1. Introduction](#1-introduction)

[2. Organization and Project settings](#2.-organization-and-project-settings)

[2.1. Introduction](#21-introduction_1)

[2.2. Organization Settings](#22-organization-settings)

[2.3. Project Settings](#23-project-settings)

[2.3.1. General permissions selection](#231-general-permissions-selection)

[2.3.2. How to set Board permissions](#232-how-to-set-board-permissions)

[2.3.3. How to set Repository permissions](#233-how-to-set-repository-permissions)

[2.3.4. How to set Wiki permissions](#234-how-to-set-wiki-permissions)

[3. Permission Settings](#3-permission-settings)

[3.1. General Concepts](#31-general-concepts)

[3.1.1. Access Level](#311-access-level)

[3.1.2. Permission/Role](#312-permissionrole)

[3.1.3. Object Security Management](#313-object-security-management)

[3.1.4. Security Group](#314-security-group)

[3.1.5. Team](#315-team)

[3.2. Policies](#32-policies)

[3.2.1. Provide Basic access level or higher access level when needed](#321-provide-basic-access-level-or-higher-access-level-when-needed)

[3.2.2. Keep build-in security group permission settings steady](#322-keep-build-in-security-group-permission-settings-steady)

[3.2.3. Always use security group as the smallest authorization unit on operation-level](#always-use-security-group-as-the-smallest-authorization-unit-on-operation-level)

[3.2.4. Recommend using team for access control on object-level](#324-recommend-using-team-for-access-control-on-object-level)

[3.2.5. Use allow rather than deny on permission assignment](#325-use-allow-rather-than-deny-on-permission-assignment)

[3.3. Example](#33-example)

[3.3.1. Example introduction](#331-example-introduction)

[3.3.2. Create new team](#332create-new-team)

[3.3.3. Backlogs/Boards access control](#333-backlogsboards-access-control)

[3.3.4. Repositories access control](#334-repositories-access-control)

[3.3.5. Pipelines access control](#335-pipelines-access-control)

[4. Azure Repos](#4-azure-repos)

[4.1. Naming Conventions](#41-naming-conventions)

[4.1.1. Repository Naming](#411-repository-naming)

[4.1.2. Branch Naming](#412-branch-naming)

[4.1.3. Commit Message](#413commit-message)

[4.2. Improved Gitflow](#42-improved-gitflow)

[4.2.1. Intro of Gitflow](#421-intro-of-gitflow)

[4.2.2. Use Branch Policies](#422-use-branch-policies)

[4.2.3. Start release from main, not develop](#423-start-release-from-main-not-develop)

[4.2.4. Typical git operation steps](#424-typical-git-operation-steps)

[4.2.5. Support of multiple product line](#425-support-of-multiple-product-line)

[4.3. Trunk based development](#43-trunk-based-development)

[4.4. Git-Security](#44-git-security)

[4.4.1 Importing legacy projects](#441-importing-legacy-projects)

[4.4.2 Use control access](#442-use-control-access)

[4.4.3 Don’t commit sensitive data](#443-dont-commit-sensitive-data)

[4.4.4 Remove sensitive data](#444-remove-sensitive-data)

[4.4.5 Rotate private keys and access tokens](#445-rotate-private-keys-and-access-tokens)

[5. Azure Pipelines](#5-azure-pipelines)

[5.1. General concepts](#51-general-concepts-1)

[5.1.1. Continuous integration](#511-continuous-integration)

[5.1.2. Continuous delivery](#512-continuous-delivery)

[5.1.3. Continuous testing](#513-continuous-testing)

[5.1.4. Pipelines](#514-pipelines)

[5.1.5. Agents](#515-agents)

[5.1.6. Deployment groups](#516-deployment-groups)

[5.1.7. Libraries](#517-libraries)

[5.1.8. Artifacts](#518-artifacts)

[5.2. Key concepts](#52-key-concepts)

[5.2.1. Triggers](#521-triggers)

[5.2.2. Stages](#522-stages)

[5.2.3. Jobs](#523-jobs)

[5.2.4. Steps](#524-steps)

[5.2.5. Scripts](#525-scripts)

[5.2.6. Tasks](#526-tasks)

[5.3. Recommendations](#53-recommendations)

[5.3.1. Use the new Azure Pipelines YAML CD features](#531-use-the-new-azure-pipelines-yaml-cd-features)

[5.3.2. Use templates to reuse YAML files](#532-use-templates-to-reuse-yaml-files)

[5.3.3. Use PAT of System ID for access auth in pipelines](#533-use-pat-of-system-id-for-access-auth-in-pipelines)

[5.3.4. Use naming conventions](#534-use-naming-conventions)

[5.3.5. Use Replace Tokens Extension to secure sensitive data](#535-use-replace-tokens-extension-to-secure-sensitive-data)

[5.3.6. Link secrets from an Azure Key Vault as variables](#536-link-secrets-from-an-azure-key-vault-as-variables)

[6. Application Security](#6-application-security)

[7. Azure DevOps Dashboards](#7-azure-devops-dashboards)

[7.1. Dashboard overview](#71-dashboard-overview)

[7.2. Dashboard Permissions](#dashboard-permissions)

[7.3. Dashboard Recommendations](#73-dashboard-recommendations)

[8. Monitoring](#8-monitoring)

[8.1. Azure DevOps Service Status](#81-azure-devops-service-status)

[8.2. Service Health Statuses](#82-service-health-statuses)

[8.3. Status History](#83-status-history)

[8.4. Reporting Availability Issues](#84-reporting-availability-issues)

[8.5. CI/CD Monitoring](#85-cicd-monitoring)

[8.5.1. Azure Pipelines](#851-azure-pipelines-1)

[8.5.2. Pipeline Agents](#852-pipeline-agents)


## 1. Introduc­­tion

This document sets out **Azure DevOps** recommended guidelines as input per sections from different teams in Henkel dx.

You can find a list of Azure DevOps organizations, which are managed by DevOps team, at this link https://docs.henkelgroup.cloud/devops/azure-devops-faq/. 

This document will focus only on guidelines recommended for the setup of Azure DevOps organizations, managed by DevOps team, as there are also several other Azure DevOps organizations which are managed through different organization owners who have set their own privacy, security guidelines and user support system.

Main responsibilities of governing Azure DevOps organizations, managed by DevOps team, are stated below:

-   Azure DevOps user license management (ordering and billing)

-   Creation of new Azure DevOps projects

-   Creation of new Azure DevOps organizations

-   Change of user access levels

-   Install extensions for projects from Azure DevOps Marketplace

-   Set organization guidelines and policies to ensure security practices

-   Consulting on best practices

User support for the Azure DevOps organizations, managed by DevOps team, is covered by DevOps team through ServiceNow. In order to create a request, please navigate to Henkel ServiceNow and search for Azure DevOps Request. No VPN connection is needed to access ServiceNow.

A list of FAQ for Azure DevOps organizations, managed by DevOps team, can be found here: [<u>Azure DevOps & GitHub FAQ - Henkel Cloud Docs (henkelgroup.cloud)</u>](https://docs.henkelgroup.cloud/devops/azure-devops-and-github-faq/).

# 2. Organization and Project settings

## 2.1. Introduction

Based on security practices, Organization settings can be modified only by users which are part of *Project Collection Administrators* permission group.

Project settings can be modified by users in the role of Project Administrator or, depending on the situation, by users which are part of *Project Collection Administrators* permission group.

## 2.2. Organization Settings

Organization settings can be checked at any time by any Azure DevOps user part of that organization, independent of the access level, by going to *Organization Settings*.

<img src="../media/image4.png" style="width:6.26389in;height:2.24097in" alt="Graphical user interface, text, application, Teams Description automatically generated" />

**Edit permissions** for the organization purpose are limited to a specific group and not to all Azure DevOps users based on below main considerations:

-   To control unwanted changes to *Billing* section: costs for Azure DevOps are covered centrally, based on an annual budget estimation

-   To limit the number of created and unused projects: Azure DevOps limits an organization at 300 projects

-   To keep a clean, “production” Azure DevOps organization: before installing an extension, DevOps team makes a quality check as Microsoft does not offer support for extensions and any installed extension will affect all projects (extensions are installed on organization level)

-   To ensure need-to-know access: access levels and permissions settings in Azure DevOps are complex. To avoid unnecessary access to certain parts of a project from the beginning, the default access level is set by default to “*Stakeholder*.” At the same time, billing changes need to be considered (a Basic access level license costs approx. 6 EUR per month, whereas a Basic + Test Plans access level license costs approx. 60 EUR per month).

Changes to Organization settings can be made depending on security advice by Henkel Teams but also at the request of Azure DevOps users in case of performance issues (e.g., increase the number of parallel jobs).­

## 2.3. Project Settings

Project settings are in the responsibility of the Project Administrator. When higher permissions are required, the Project Administrator can raise a request or a consultation to DevOps team. Detailed official Microsoft documentation can be found here<u>: [Azure Boards Settings & process documentation \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/reference/?view=azure-devops)</u>.

Project Administrators can take several actions to setup the projects in such a way to make sure that members have access to areas in their work scope. Settings can be made to:

-   Change individual permissions

-   Grant or restrict permissions

-   Set dashboard permissions

-   Set wiki permissions

-   Secure Boards

-   Secure Repos

-   Secure Pipelines

-   Secure Test Plans

-   Secure Artifacts

Boards are automatically created when you create a project or add a team. Each team has access to their own product and portfolio boards and project administrators must take care to secure team content as, by default, every newly created team will have access to full project content. Detailed Microsoft documentation can be found at the following link: [<u>Set permissions and access for work tracking - Azure DevOps \| Microsoft Docs</u>](https://docs.microsoft.com/en-us/azure/devops/organizations/security/set-permissions-access-work-tracking?view=azure-devops).

Team administrators can configure settings for their team's tools. Organization owners and members of the Project Administrators group can configure settings for all teams. Project Administrators have sufficient permissions for setting majority of the above permissions, with exception of the below, which are part of the organization-level permissions:

-   Create, delete, or edit a process (Inheritance process model)

-   Delete field from account (Inheritance process model)

-   Manage process permissions (Inheritance process model)

-   Edit collection level permissions

Area path permissions let you grant or restrict access to edit or modify work items, test cases, or test plans assigned to those areas. You can restrict access to users or groups. You can also set permissions for who can add or modify areas or iterations for the project. You define both areas and iterations for a project from the *Project Settings>Work>Project configuration.*

Each backlog is associated with a team. Team configuration settings determine the work items that will appear on the team backlog. Specifically, the team administrator defines the following for their team:

-   Selects the Area Paths that are active for the team, only work items assigned to these area paths appear on the team's backlog

-   Sets the default Area Path and Iteration Path used when defining work items from the team backlog

-   Selects the Iteration Paths that are active for the team

-   Determines which backlog levels are active for the team

-   Defines how bugs will be treated, as requirements or as tasks

### 2.3.1. General permissions selection

This is the permissions selection which will appear multiple times when opening the security settings in an Azure DevOps project.

<img src="../media/image5.png" style="width:6.26389in;height:4.3981in" />

Here you can set access depending on user or group part of the project. After selecting a user or group on the left side you can change their accesses on the right side, for example denying the creation of branches or other features. Useful link: [<u>Set permissions and access for work tracking.</u>  
](https://docs.microsoft.com/en-us/azure/devops/organizations/security/set-permissions-access-work-tracking?view=azure-devops)

### 2.3.2. How to set Board permissions

The permissions settings for Boards can be found by opening the Project settings \> Boards \> Team configuration \> Areas. Here you can add and edit permission areas by either creating a new area or editing an existing one by clicking on … \> Security, where the usual permissions screen mentioned in [section 2.3.1](#231-general-permissions-selection) is found.

<img src="../media/image6.png" style="width:6.23008in;height:3.11304in" />

### 2.3.3. How to set Repository permissions

The permissions settings for the Azure DevOps Repositories can be found by opening the Project settings \> Repos \> Repositories \> Security where the same security page as mentioned in [section 2.3.1](#231-general-permissions-selection) is used.

<img src="../media/image7.png" style="width:6.26111in;height:3.19097in" />

### 2.3.4. How to set Wiki permissions

The permissions settings for the Wiki can be found at Overview \> Wiki \> ⋮ \> Wiki Security. Here you are presented with the same access settings menu as mentioned in [section 2.3.1](#231-general-permissions-selection) with the ability to change access settings for users or groups. Useful link: [Manage permissions for READMEs and wiki pages - Azure DevOps \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/project/wiki/manage-readme-wiki-permissions?view=azure-devops)

<img src="../media/image8.png" style="width:5.64357in;height:3.00206in" />

# 3. Permission Settings

## 3.1. General Concepts

### 3.1.1. Access Level

Each user is assigned an access level which grants or restricts access to select web portal features. Supported access levels:

-   Stakeholder

-   Basic

-   Basic + Test Plans

-   Visual Studio subscription, like Visual Studio Enterprise, Visual Studio Professional, Visual Studio Test Professional

For access level details, please refer [About access levels - Azure DevOps \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/organizations/security/access-levels?view=azure-devops).

### 3.1.2. Permission/Role

*Permission* grants or restricts an operation on organization, project, and object-level. Those objects using permission include Dashboard, Area, Repository, Branch, Pipeline, Release, Task Group. *Role* defines access to the following objects: Environment, Library, Deployment Group, Artifact.

**Permission States**

There are five possible assignments made to a permission. They grant or restrict access as indicated.

| **State**       | **Access**   |
|-----------------|--------------|
| Allow           | **Grant**    |
| Inherited allow | **Grant**    |
| Deny            | **Restrict** |
| Inherited deny  | **Restrict** |
| Not set         | **Restrict** |

-   *Allow* or *Deny* explicitly grants or restricts users from performing specific tasks and are usually inherited from group membership

-   *Not set* implicitly denies users the ability to perform tasks that require that permission but allows membership in a group that does have that permission set to take precedence, also known as *Allow (inherited)* or *Inherited allow* and *Deny (inherited)* or *Inherited deny*

-   For most groups and almost all permissions, ***Deny* overrides *Allow***. If a user belongs to two groups, and one of them has a specific permission set to *Deny*, that user is not able to perform tasks that require that permission even if they belong to a group that has that permission set to *Allow*

-   For members of the Project Collection Administrators, permissions assigned to these groups take precedent over any *Deny* set within any other group to which that member might belong. Project Collection Administrators permissions will not take precedence for work item operations, such as deletion. *Deny* will override *Allow* for these permissions.

### 3.1.3. Object Security Management

| **Category** | **Object**                                     | **Managed by** |
|--------------|------------------------------------------------|----------------|
| Boards       | Area                                           | Permission     |
| Repos        | All Repositories                               | Permission     |
| Repos        | Repository (inherited by default)              | Permission     |
| Repos        | Branch (inherited by default)                  | Permission     |
| Pipelines    | All Pipelines                                  | Permission     |
| Pipelines    | Pipeline Folder (inherited by default)         | Permission     |
| Pipelines    | Pipeline (inherited by default)                | Permission     |
| Pipelines    | Environments                                   | Role           |
| Pipelines    | All Release Pipelines                          | Permission     |
| Pipelines    | Release Pipeline Folder (inherited by default) | Permission     |
| Pipelines    | Release Pipeline (inherited by default)        | Permission     |
| Pipelines    | Library                                        | Role           |
| Pipelines    | Variable Group                                 | Role           |
| Pipelines    | Security File                                  | Role           |
| Pipelines    | Task Groups                                    | Permission     |
| Pipelines    | Deployment Groups                              | Role           |

### 3.1.4. Security Group

Security Group defines a group of permission/role assignments, like Project Administrators, Contributors, Readers, etc. Members of the security group inherit the permission/role assigned to the group.

### 3.1.5. Team

Teams have most functionalities of security groups. Comparing with security groups, teams have more features like:

-   Each team has its own Dashboard

-   Each team has its own Backlog/Board

-   Each team has its own Sprints

-   Teams can own Areas

## 3.2. Policies

### 3.2.1. Provide Basic access level or higher access level when needed

With Stakeholder access, users can create and modify work items and create and save queries. They have limited access to several Azure Boards features. They also can view and approve release pipelines and perform administrative tasks when granted administrative permissions or added to an administrative group.

If a Stakeholder needs access to one or more of the following features - which support the daily work of product owners, team leads, developers, testers, and project administrators - the Basic access level needs to be provided:

-   Change the priority of an item within a backlog

-   Delete work items or move work items to another project

-   Change fields on cards on a Kanban board or Taskboard

-   Drag-and-drop work items to the Planning pane to assign to a sprint

-   Add new work item tags

-   Create shared queries, view charts, and modify the home page

-   View Delivery Plans (a Marketplace extension)

-   Access the full set of features under Boards, Pipelines, Repos, or Test Plans

### 3.2.2. Keep build-in security group permission settings steady

Azure DevOps provides some built-in security groups by default, like Project Administrators, Contributors, Readers, etc. All these security groups have the same permission/role assignments within different projects. Keeping the default permission/role assignments of these pre-defined security groups steady makes it possible to use them as the baseline of customized security groups and teams.

### 3.2.3. Always use security group as the smallest authorization unit on operation-level

Comparing to assigning permissions to a single user directly, assigning permissions to a security group of which make the user as a member brings the following benefits:

-   Instead of the username, a security group can have a more comprehensible name to indicate the user's responsibility

-   A security group can be reused as a parent group. In Azure DevOps, a security group can be added as a member of another security group, and the child group can inherit its parent group's permission assignments

-   If there are additional users with the same authorization in future, by adding the users into the security group the operation can be simplified significantly.

### 3.2.4. Recommend using team for access control on object-level

Comparing to granting or restricting access for a single user, granting, or restricting access for a team of which make the user as a member brings the following benefits:

-   Instead of the username, a team can have a more comprehensible name to indicate the user's responsibility

-   For each new created team, Azure DevOps creates an area which can be used for work items access control

-   If there are additional users with the same authorization in future, by adding the users into the team, the operation can be simplified significantly.

### 3.2.5. Use allow rather than deny on permission assignment

In Azure DevOps, one permission of an object is in the *Not Set* status by default, unless it or its parent object is assigned *Allow* or *Deny* status explicitly. An operation is granted only when the corresponding permission has *Allow* or *Inherited Allow* assignment. Based on the Principle of Least Privilege, access needs to be granted by explicit assignment. It is recommended to use *Allow* rather than *Deny* on permission assignment.

One of the proposals is to use a security group with less than required permissions as the baseline, then add the necessary privileges explicitly by assigning *Allow* to additional required permissions.

## 3.3. Example

### 3.3.1. Example introduction

We use *Test Project 1* project in Henkel dx organization as an example to show how to follow the policies listed above.

In *Test Project 1* project, there are three types of users in brief. We have two external providers part of the same project, but they don’t need to access the backlogs/boards, code repos and CI/CD pipelines of each other, which means the access control is on the object-level rather than the operation-level. So, users from these two outsourcers need to be assigned into two different teams, as in the table shown below.

| **Users**                                                                               | **Permission description**                                     | **Target Team** | **Baseline Security Group** |
|-----------------------------------------------------------------------------------------|----------------------------------------------------------------|-----------------|-----------------------------|
| Henkel project users, including PM/PO, stakeholders, developers, DevOps engineers, etc. | Contribute to all backlogs/boards, code repos, pipelines       | Test Project 1  | Contributors                |
| Users from external provider – Company 3                                                | Contribute to their own backlogs/boards, code repos, pipelines | Team 3          | Project Valid Users         |
| Users from external provider – Company 4                                                | Contribute to their own backlogs/boards, code repos, pipelines | Team 4          | Project Valid Users         |

### 3.3.2. Create new team

As in the figure shown below, we leave the Permissions field empty when creating a new team, because the built-in security groups grant access to all the objects by default in Azure DevOps. We also need to create an area path for the new team, as we will use it to control the access to the team’s backlogs/boards.

<img src="../media/image9.png" style="width:5.79214in;height:3.39695in" alt="Graphical user interface, application, Teams Description automatically generated" />

As there is no security group assigning to the new team, it is assigned to the built-in “Project Valid Users” security group by default, which we use as the baseline, as in the figure shown below.

<img src="../media/image10.png" style="width:6.26389in;height:1.89375in" alt="Graphical user interface, application, Teams Description automatically generated" />

The permission “View project-level information” needs to be set to *Allow* for the Team, as the figure shown below.<img src="../media/image11.png" style="width:5.83077in;height:3.73731in" alt="Table Description automatically generated" />

### 3.3.3. Backlogs/Boards access control

In Azure DevOps, access to Backlogs/Boards is controlled through the Area property of each work item. We grant Team 4 access to the area – Test Project\\Team 4, as in the figure shown below:

<img src="../media/image12.png" style="width:5.94566in;height:3.85084in" alt="Graphical user interface, text, application, email Description automatically generated" />

Assign related permissions to *Allow* for the Area to Team 4, as in the figure shown below:

<img src="../media/image13.png" style="width:6.0099in;height:3.08024in" alt="Graphical user interface, application, Teams Description automatically generated" />

### 3.3.4. Repositories access control

The baseline security group - Project Valid Users has no access to any code repository by default. We can grant Team 4 access to specified code repositories, as the figure shown below.

<img src="../media/image14.png" style="width:5.92392in;height:3.99044in" />

This operation needs to be taken on every repository the team needs to contribute.

### 3.3.5. Pipelines access control

The baseline security group - Project Valid Users has no access to any pipelines by default. We can grant Team 4 access to specified pipelines, as in the figure shown below. It’s recommended to group pipelines belonging to the team into one folder to save the effort on permission assignment:

<img src="../media/image15.png" style="width:5.92361in;height:2.85739in" />

Assign related permissions to *Allow* for the team, as in the figure shown below:

<img src="../media/image16.png" style="width:6.37624in;height:3.70981in" />

# 4. Azure Repos

## 4.1. Naming Conventions

### 4.1.1. Repository Naming

The naming convention for Azure Repository is as follows: ***CompanyName-ProjectName-ApplicationName-Extras***

| Naming Part      | Description                                                                   |
|------------------|-------------------------------------------------------------------------------|
| Company Name     | e.g. henkel                                                                   |
| Project Name     | e.g. projectname                                                              |
| Application Name | Application or component name within the project, e.g. web, ios-app, spoc-api |
| Extras           | Additional information if needed                                              |

e.g.

-   henkel-projectname-spoc-api

-   henkel-washinglabelscan-web

-   henkel-armarkup-docs

### 4.1.2. Branch Naming

We use the following branch naming convention:

-   main

-   hotfix/#{work item number}\_{description}

-   develop

-   release/#{work item number}\_{description}

-   feature/#{work item number}\_{description}

### 4.1.3. Commit Message

It is recommended to follow a conventional pattern/format on the commit messages. Here’re some examples:
```
chore(release): 1.2.0 (#80837)

feat: add styles for single shade products (#93481)

fix: allow removing hair color effect (#93779)

docs: fix typos in API references wiki (#88995)
```
Format of the commit message:
```
\<type>(\<scope>): \<subject> (\<#issue>)

\<BLANK LINE>

\<body>

\<BLANK LINE>

\<footer>

The \<type> part describes the kind of the change that this commit is providing.
```
Allowed values:
```
-   feat, new feature

-   fix, bug fix

-   docs, changes to documentation

-   style, code formatting; no production code change

-   refactor, refactoring production code

-   test, adding missing tests, refactoring tests, etc.; no production code change

-   chore, updating azure pipeline, etc.; no production code change

The \<scope> part can be anything specifying scope of the commit change.
```
Example values:
```
-   init

-   release

-   config

-   client

-   etc.

The \<scope> part can be empty (e.g., if the change is a global or difficult to assign a scope), in which case the parentheses are omitted.

The \<subject> part is a very short description of the change.

-   use imperative, present tense: “change” not “changed” nor “changes”

-   don’t capitalize first letter

-   no dot(.) at the end

-   limit the subject line to 72 characters

The \<#issue> part refers to the work item through its ID number. For example, we can use ID number of Product Backlog Item or Task for the \<#issue>. After being squash merged to the develop/main branches, this work item ID referenced by commits on feature/hotfix/release branches are listed at the footer of the Pull Request’s commit message automatically.
```
Here is a recommended tool to line the commit message - [husky](https://github.com/typicode/husky), which has over 23.6k stars on Github.

## 4.2. Improved Gitflow

For details on version control and improved Gitflow, please see the [Development Guidelines/Version control](https://docs.henkelgroup.cloud/development/Software-Development-Standards-Guidelines/Version-Control/) section.

# 5. Azure Pipelines

## 5.1. General concepts

Azure Pipelines automatically builds and tests code projects to make them available to others. It works with just about any language or project type. Azure Pipelines combines continuous integration (CI) and continuous delivery (CD) to constantly and consistently test and build your code and ship it to any target.

### 5.1.1. Continuous integration

Continuous integration (CI) is the practice used by development teams to simplify the testing and building of code. CI helps to catch bugs or problems early in the development cycle, which makes them easier and faster to fix.

Automated tests and builds are run as part of the CI process. The process can run on a set schedule, whenever code is pushed, or both. Items known as artifacts are produced from CI systems. They're used by the continuous delivery release pipelines to drive automatic deployments.

### 5.1.2. Continuous delivery

Continuous delivery (CD) is a process by which code is built, tested, and deployed to one or more test and production stages. Deploying and testing in multiple stages helps drive quality.

Continuous integration systems produce deployable artifacts, which include infrastructure and apps. Automated release pipelines consume these artifacts to release new versions and fixes to existing systems.

Monitoring and alerting systems run constantly to drive visibility into the entire CD process. This process ensures that errors are caught often and early.

### 5.1.3. Continuous testing

Whether your app is on-premises or in the Cloud, you can automate build-deploy-test workflows and choose the technologies and frameworks, then test your changes continuously in a fast, scalable, and efficient manner:

-   Maintain quality and find problems as you develop. Continuous testing with Azure DevOps ensures your app still works after every check-in and build, enabling you to find problems earlier by running tests automatically with each build

-   Any test type and any test framework. Choose the test technologies and frameworks you prefer to use

-   Rich analytics and reporting. When your build is done, review your test results to start resolving the problems you find. Rich and actionable build-on-build reports let you instantly see if your builds are getting healthier. But it's not just about speed - detailed and customizable test results measure the quality of your app.

### 4.1.4. Pipelines

A pipeline defines the continuous integration and deployment process for your software product. It can contain one or more stages. It can be thought of as a workflow that defines how your test, build, and deployment steps are run.

### 5.1.5. Agents

When your build or deployment runs, the system begins one or more jobs. An agent is computing infrastructure with installed agent software that runs one job at a time. For example, your job could run on a Microsoft-hosted Ubuntu agent. Azure Pipelines supports two types of agents, Microsoft-hosted agents, and Self-hosted agents.

Azure Pipelines provides a pre-defined agent pool named Azure Pipelines with Microsoft-hosted agents. Use Self-hosted agents when you want more control to install dependent software needed for your builds and deployments. Also, machine-level caches and configuration persist from run to run, which can boost speed.

### 5.1.6. Deployment groups

A deployment group is a set of deployment target machines that have agents installed. A deployment group is just another grouping of agents, like an agent pool. You can set the deployment targets in a pipeline for a job using a deployment group.

### 5.1.7. Libraries

Library is a collection of included build and release assets for a project. Assets defined in a library can be used in multiple build and release pipelines of the project. The Library tab can be accessed directly in Azure Pipelines. At present, the library contains two types of assets:

-   **Variable groups** are used to store values that you want to control and make available across multiple pipelines. You can also use variable groups to store secrets and other values that might need to be passed into a YAML pipeline

-   **Secure files** are used to store files such as signing certificates, Apple Provisioning Profiles, Android Keystore files, and SSH keys on the server without having to commit them to your source repository.

### 5.1.8. Artifacts

An artifact is a collection of files or packages published by a run. Artifacts are made available to subsequent tasks, such as distribution or deployment.

To produce packages that can be consumed by others, you can publish NuGet, npm, or Maven packages to the built-in package management repository in Azure Pipelines. You also can use any other package management repository of your choice.

## 5.2. Key concepts

<img src="../media/image20.png" style="width:6.26389in;height:2.2875in" alt="Graphical user interface Description automatically generated with medium confidence" />

### 5.2.1. Triggers

A trigger is used to tell the pipeline when to run. You can configure a pipeline to run upon a push to a repository, at scheduled times, or upon the completion of another build. All these actions are known as triggers. Azure Pipelines supports many types of triggers:

-   **Push trigger** causes a pipeline to run whenever you push an update to the specified branches, or you push specified tags

-   **PR trigger** causes a pipeline to run whenever a pull request is opened with one of the specified target branches, or when changes are pushed to such a pull request

-   **Scheduled trigger** specifies a schedule on which branches are built

-   **Pipeline trigger** specifies the triggering pipeline as a pipeline resource and add a trigger to run your pipeline upon the successful completion of the triggering pipeline.

### 5.2.2. Stages

A stage is a logical boundary in the pipeline. It can be used to mark separation of concerns (for example, Build, QA, and production). Each stage contains one or more jobs. When you define multiple stages in a pipeline, by default, they run one after the other. You can specify the conditions for when a stage runs. When you are thinking about whether you need a stage, ask yourself:

-   Do separate groups manage different parts of this pipeline? For example, you could have a test manager that manages the jobs that relate to testing and a different manager that manages jobs related to production deployment. In this case, it makes sense to have separate stages for testing and production

-   Is there a set of [approvals](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/approvals?view=azure-devops) that are connected to a specific job or set of jobs? If so, you can use stages to break your jobs into logical groups that require approvals

-   Are there jobs that need to run a long time? If you have part of your pipeline that will have an extended run time, it makes sense to divide them into their own stage.

### 5.2.3. Jobs

A stage contains one or more jobs. Each job runs on an agent. A job represents an execution boundary of a set of steps. All the steps run together on the same agent. Stages are most useful when you want to parallelize jobs or run a series of steps in different environments. For example, you might build two configurations - x86 and x64. In this case, you have one stage and two jobs. One job would be for x86 and the other job would be for x64.

### 5.2.4. Steps

A step is the smallest building block of a pipeline. For example, a pipeline might consist of build and test steps. A step can either be a script or a task. A task is simply a pre-created script offered as a convenience to you.

### 5.2.5. Scripts

A script runs code as a step in your pipeline using command line, PowerShell, or Bash. You can write cross-platform scripts for macOS, Linux, and Windows. Unlike a task, a script is custom code that is specific to your pipeline.

### 5.2.6. Tasks

A task is the building block for defining automation in a pipeline. A task is packaged script or procedure that has been abstracted with a set of inputs.

## 5.3. Recommendations

### 5.3.1. Use the new Azure Pipelines YAML CD features

In April 2020, Microsoft announced GA (General Availability) of the new Azure Pipelines YAML CD features. It brought a unified YAML experience, with which we can configure each of our pipelines to do CI, CD or both.

-   **Multi-stage YAML pipelines (for CI and CD)**

Defining the pipelines with YAML documents allows us to check the configuration of our CI/CD into source control with the application’s code, for easy management, versioning, and control.

When we define multiple stages in a pipeline, by default, they run sequentially in the order in which we define them in the YAML file. But we can customize the order with dependencies, conditions as required.

For details, please refer [Stages in Azure Pipelines - Azure Pipelines \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/stages?view=azure-devops).

-   **Resources in YAML pipelines**

A resource is anything used by a pipeline that lives outside the pipeline. Resources provide us the full traceability of the services consumed in your pipeline including the version, artifacts, associated commits, and work-items. We can fully automate our DevOps workflow by subscribing to trigger events on our resources. Pipeline resources include pipelines, builds, repositories, containers, and packages.

For details, please refer [Resources - Azure Pipelines \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/resources?view=azure-devops).

-   **Environments**

An environment is a collection of resources that can be targeted for deployment from a pipeline. Environments can include Kubernetes clusters, Azure web apps, virtual machines, databases etc. Typical examples of environment names are Dev, Test, QA, Staging, and Production.

For details, please refer [Environment - Azure Pipelines \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops)

-   **Approvals and checks**

Checks enable the resource owner to control whether a stage in a pipeline can consume the resource. As an owner, we can define the checks that must be met prior a stage consuming that resource can start. For example, a manual approval checks on an environment ensures that deployment can happen only after the reviewers have signed-off.

For details, please refer [Pipeline deployment approvals - Azure Pipelines \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/approvals?view=azure-devops)

### 5.3.2. Use templates to reuse YAML files

Templates let us define reusable content, logic, and parameters. Templates function in two ways: you can insert reusable content with a template, or you can use a template to control what is allowed in a pipeline.

If a template is used to include content, it functions like an include directive in many programming languages. Content from one file is inserted into another file. When a template controls what is allowed in a pipeline, the template defines logic that another file must follow.

For details, please refer [Templates - Azure Pipelines \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/templates?view=azure-devops).

### 5.3.3. Use PAT of System ID for access auth in pipelines

Sometimes steps in our pipelines may need to access Azure DevOps resources like repos, artifacts, etc. For example, to consume a private NPM package, we need to use Personal Access Token (PAT) to grant the publishing/restoring the package to/from the feed in Azure Artifacts. Instead of using PAT of a concrete user, it’s recommended to use PAT of a System ID which is owned by the user account. The System ID’s ownership can be transferred to another user account when needed.

The operation steps of creating PAT of a System ID are listed in Table 6-1.

| Step | Name                                             | Operation                                                                                                                                                                     |
|------|--------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1    | Create the System ID                             | [myID](https://myid.henkelgroup.net/home.jsf) -> Manage Secondary Identity -> Create Secondary Identity                                                                       |
| 2    | Request Azure AD and Windows Login (AD) accounts | [myID](https://myid.henkelgroup.net/home.jsf) -> Manage Identity -> Edit Additional Identity -> Manage (the System ID) -> Accounts -> Request Account                         |
| 3    | Reset password of System ID                      | [myID](https://myid.henkelgroup.net/home.jsf) -> Manage Identity -> Edit Additional Identity -> Manage (the System ID) -> Passwords -> Change (the password of Windows Login) |
| 4    | Create PAT with requisite privileges             | Login [Azure DevOps](https://dev.azure.com/henkeldx) with System ID credential -> User settings -> Personal access tokens -> New Token                                        |
| 5    | Transfer the ownership of System ID if needed    | [myID](https://myid.henkelgroup.net/home.jsf) -> Manage Secondary Identity -> Change Owner of Secondary Identity                                                              |

**Table 6-1 Create PAT of a System ID**

The System ID’s AAD account needs be added into the related projects and assigned with proper User Access Level to access resources like repos.

### 5.3.4. Use naming conventions

To align the definition of the environments and stages used in Azure Pipelines, we use the following naming convention.

-   **Environments**

| Name    | Description                                                         |
|---------|---------------------------------------------------------------------|
| Dev     | Environment used to deploy the artifact built on develop branch     |
| Staging | Environment used to deploy the artifact built on release branch     |
| Prod    | Environment used to deploy the artifact built on main/master branch |

-   **Stages**

| Name               | Description                         |
|--------------------|-------------------------------------|
| Build              | Stage to test code, build artifact  |
| Dev Deployment     | Stage to deploy dev environment     |
| Staging Deployment | Stage to deploy staging environment |
| Prod Deployment    | Stage to deploy prod environment    |

### 5.3.5. Use Replace Tokens Extension to secure sensitive data

Sensitive data (Username, Password, API Keys, DB Connection String, etc.) should not be hardcoded and stored in source code repository to avoid security risks. We can use tokens with specific syntax as placeholders in our source code and replace them at building time. Replace Token task is just one tool which can help us. It is used to replace tokens in files with values stored in variable groups.

To use the Replace Token task in your pipeline:

1.  The Replace Tokens Extension needs to be installed in organization settings

2.  Create variable group to store tokens in Azure DevOps Library

3.  Reference the variable group and add Replace tokens task in the pipeline to replace tokens in files.

For details, please refer to [Replace Tokens - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=qetza.replacetokens).

### 5.3.6. Link secrets from an Azure Key Vault as variables

In Azure DevOps, variables in variable groups can be added manually or via Azure CLI scripts. But we can also link the secrets from Azure Key Vault in variable groups.

<table><colgroup><col style="width: 23%" /><col style="width: 38%" /><col style="width: 38%" /></colgroup><thead><tr class="header"><th>Type</th><th>Pros</th><th>Cons</th></tr></thead><tbody><tr class="odd"><td>Variable group maintained manually</td><td><p>- Faster and easier to configure variables without dependency</p><p>- Safer as the encrypted value will never be discovered</p></td><td><p>- No backup or version control for the variables</p><p>- Can’t be re-used across Azure DevOps projects</p></td></tr><tr class="even"><td>Variable group link with Azure Key Vault</td><td><p>- Admins can manage the secrets centrally from Azure Key Vaults</p><p>- Set up secrets once and re-use it across Azure DevOps projects via service connections</p><p>- Enable version control for secrets</p><p>- Easier to audit the Key Vault access via Azure Key Vault logging</p></td><td><p>- Azure resources is mandatory</p><p>- Permission control in both Azure Key Vault and Azure DevOps</p><p>- When adding or deleting secrets in key vault, we need to refresh the corresponding variable groups</p><p>- Cryptographic keys and certificates are not supported</p></td></tr></tbody></table>

For linking Azure Key Vault, you can find the following additional secrets management notes:

-   Only the secret names are mapped to the variable group, not the secret values. The latest version of the value of each secret is fetched from the vault and used in the pipeline linked to the variable group during the run

-   Any changes made to existing secrets in the key vault, such as a change in the value of a secret, will be made available automatically to all the pipelines in which the variable group is used

-   When new secrets are added to the vault, or a secret is deleted from the vault, the associated variable groups are not updated automatically. The secrets included in the variable group must be explicitly updated for the pipelines using the variable group to execute correctly.

# 6. Application Security

-   Please refer to this [link](https://docs.henkelgroup.cloud/security/DevSecOps/intro/) for any Security related information.

# 7. Azure DevOps Dashboards

## 7.1. Dashboard overview

Dashboards are associated with a **team** or a **project** and display configurable charts and widgets. By default, all teams have access to all project dashboards. The default Dashboard type is **Team** Dashboard.

Important info: a team dashboard is automatically created when a new team is created from *Project settings – General – Teams – New team.* When the respective team is deleted, the team dashboard with its content **will also be automatically deleted**.

A dashboard can display information across **different projects** in Azure DevOps in the following conditions:

-   In the query conditions for the Dashboard widget, the *“Query across projects”* option is enabled, and the fields *“Team Project”* are populated with the desired project names

-   To see the project dropdown list, the user creating the query must be a valid member of the projects

<img src="../media/image21.png" style="width:6.26389in;height:2.91667in" />

Dashboards can also be created manually by going to *Overview – Dashboards – All Dashboards – New Dashboard*:

-   **Team Dashboard:** The dashboard is associated with a single team. Team admins can edit and manage this dashboard. Everyone can view the dashboard

-   **Project Dashboard:** The dashboard is not associated with a team. You decide which users and groups can edit and manage this dashboard. Everyone can view the dashboard.

Dashboards can be copied from one team to another or between projects by using the Copy Dashboard functionality. You can find this feature by going into one of your dashboards, then to the *More options button* and then *Copy Dashboard*:

<img src="../media/image22.png" style="width:6.57447in;height:1.50665in" />

## 7.2. Dashboard Permissions

All members of the Project Valid Users group can view dashboards. To add, edit, or manage a team dashboard, you must have **Basic** access or greater and be a team admin, a project admin, or have dashboard permissions. In general, you need to be a team member for the currently selected team to edit dashboards. More information on dashboard permission can be found in official Microsoft documentation [here](https://docs.microsoft.com/en-us/azure/devops/report/dashboards/dashboard-permissions?view=azure-devops).

To manage who can delete, edit, or manage permissions **for a manually created Dashboard**, go to *Overview – Dashboards – All Dashboards* and from the More Options icon … select *Security*.

<img src="../media/image23.png" style="width:6.26389in;height:3.20903in" alt="Graphical user interface Description automatically generated" />

You can modify the Dashboard permissions for an **Azure DevOps group** or for specific **Azure DevOps users**. The default setting for Project Valid Users is *“Not set”*, which in Azure DevOps context means *“Deny”.* If we want to give a user or a group the permission to delete, edit or manage permissions, we need to change the setting to *“Allow.”*

<img src="../media/image24.png" style="width:6.26389in;height:2.94653in" alt="Graphical user interface, application, Teams Description automatically generated" />

Permission settings differ between dashboards created once a team was created and manually created Team dashboards. In the first case, all team members will have, by default, the permission to edit the team dashboard.

If a user reports that they can't create or edit a team dashboard, and you've set the permissions to allow them to do so, check that they have been added as a member of the team. This includes adding them as a team member to the default project team.

## 7.3. Dashboard Recommendations

Many widgets are configurable or are scoped to a team or to the current user identity. Following dashboards can be created to monitor status, progress, and trends across several teams:

-   **Management Dashboard**

    -   **Epic/Feature** view by using *Embedded web page* widget which adds a configurable tile to display the contents of a web page

<img src="../media/image25.png" style="width:6.26389in;height:2.20694in" alt="Graphical user interface, application Description automatically generated" />

-   Markdown Widget, which adds a configurable tile to display any type of information, guidance, or links that you want

<img src="../media/image26.png" style="width:6.26389in;height:0.95625in" />

-   Sprint Goal Widget

-   Business Value of the previous Sprints Widget

-   Open features Widget

-   Team Velocity Widget

-   Open Bugs Widget

-   Team Cycle Time Widget

-   Burnup chart Widget

<!-- -->

-   **Team Dashboard**

    -   Backlog items by state Widget

    -   Open tasks Widget

    -   Team Velocity Widget

    -   Sprint Burndown Widget

    -   Open bugs in backlog by severity chart

    -   Backlog items per state in sprint chart

    -   Tiles for open bugs and product backlog items

    -   Bug cycle time Widget

    -   All open bugs by Iteration

    -   New bugs over time chart

    -   Bugs in current sprint

    -   Impediments chart

-   **PR Dashboard**

    -   Team velocity Widget

    -   Product backlog items in current sprint by state chart

    -   Tile for number of bugs in current sprint

    -   Bug Cycle time Widget

    -   Team sprint burndown Widget

    -   **Sprint backlog** view by using the *Embedded web page* widget which adds a configurable tile to display the contents of a web page

# 8. Monitoring

## 8.1. Azure DevOps Service Status

Microsoft has built a dedicated monitoring status page for the availability of Azure DevOps services. This enables users to check the status of Azure DevOps services for any region in a self-service like approach: <https://status.dev.azure.com/>

**Azure DevOps Service Health Matrix**

Users can track the availability of Azure DevOps with a health matrix that Microsoft has invented as a single point of truth for indicating the status of Azure DevOps.

<img src="../media/image27.png" style="width:6.26389in;height:3.20603in" alt="A picture containing chart Description automatically generated" />

The matrix does not only consider availability within a certain region, but it also considers availability of the different sub-services such as Boards, Repos or Pipelines. This horizontal and vertical split of regions and sub-services leads to a high available and fault tolerant design of Azure DevOps: One unhealthy sub-service doesn’t make the overall application unusable. If the Azure Repos service is down in the US at some point of time, other Azure DevOps services would still be usable in the same region and users in the EU won’t even be impacted at all for example.

## 8.2. Service Health Statuses

We have 4 statuses that describe the availability of the different Azure DevOps sub-services:

<img src="../media/image28.png" style="width:5.40278in;height:0.61111in" alt="Service status indicators" />

Those statuses reflect the severity of a service health event based on the number of customers affected by the issue. For instance, the highest severity (unhealthy) impacts a large percentage of users and makes the Azure DevOps service unusable for those.

-   **Healthy**:

    -   Indicates the service is broadly available.

-   **Degraded**:

    -   Indicates a lower-severity event that affects the performance of a service feature but doesn't impact broad service availability.

-   **Unhealthy**:

    -   Indicates a high-severity event that affects the performance of a service and its broad availability.

-   **Advisory**:

    -   Indicates that a service is under investigation to determine the performance and availability impact.

## 8.3. Status History

We can see non-healthy events in the status history: <https://status.dev.azure.com/_history>

By navigating through the status history, a user can clearly understand when an event happened, what severity it had, what services were involved and in what region it occurred.

In case that service disruptions get noticed that are in the past, we can simply retrace it by filtering for it. The filter mechanism allows to filter for events that go back up to 1 year in the past.

## 8.4. Reporting Availability Issues

If a user detects an issue which is not yet visible on the Azure DevOps Services health page, there is the possibility to report this issue using the “Report a Service Availability Issue” form. It’s also possible to report an issue using the Azure DevOps Services virtual support agent: <https://azure.microsoft.com/en-gb/support/devops/>

## 8.5. CI/CD Monitoring

### 8.5.1. Azure Pipelines

Pipeline runs are automatically monitored by Azure and those can be retraced by navigating to the pipeline itself:

-   Pipelines > Chose Pipeline > Select Pipeline Run

Afterwards build information is shown and the user can see if the build execution has passed successfully or what caused the pipeline run to fail:

<img src="../media/image29.png" style="width:6.26389in;height:3.43542in" alt="Graphical user interface, application, Teams Description automatically generated" />

### 8.5.2. Pipeline Agents

Pipeline Agents can be monitored by navigating to the specific Agent Pool for which the user wants to get build information details:

-   Project Settings > Agent Pools > Select an agent pool

The user should be able to see an overview of all recent jobs that were processed by the chosen agent pool:

<img src="../media/image30.png" style="width:6.26389in;height:1.52778in" alt="Graphical user interface, application Description automatically generated" />

Furthermore, it is possible to see the status of all agents which are belonging to the specific agent pool. To get this overview the user needs to click on the “Agents” tab:

<img src="../media/image31.png" style="width:6.26389in;height:1.875in" alt="Graphical user interface, table Description automatically generated" />

It can happen from time to time that an agent pool is fully occupied which can lead to long waiting times before the pipeline execution can even start. In the agent pool overview, it’s possible to see how many pipeline agents are occupied by a pipeline run and how many are idle. In case users notice any disruptions caused by long queue times, they can contact DevOps team at devops_support@henkel.com for troubleshooting and finding a solution.












---


**Document owner, change history and version number**
<table><colgroup><col style="width: 73%;" /><col style="width: 26%;" /></colgroup>
<thead>
<tr class="header">
<th><strong>Document owner</strong></th>
<th><strong>Notes</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong><a href="https://henkelgroup.sharepoint.com/teams/DevOps/SitePages/DevOps.aspx">DevOps Team</a> (devops_support@henkel.com)</strong></td>
<td>&nbsp;</td>
</tr>
<tr class="even">
<td><strong>Document Revisions</strong></td>
<td>&nbsp;</td>
</tr>
<tr class="odd">
<td>
<p>15.04.2021,&nbsp;V 0.1, Initial draft version of the Guideline</p>
<p>Sections:</p>
<ol type="1">
<li>
<p>Introduction -- DevOps Team</p>
</li>
<li>
<p>Organization and Project settings -- DevOps Team</p>
</li>
<li>
<p>Permission Settings -- Digital Factory Shanghai Team</p>
</li>
<li>
<p>Azure Boards --&nbsp;DevOps Team</p>
</li>
<li>
<p>Azure Repos&nbsp;--&nbsp;Digital Factory Shanghai Team</p>
</li>
<li>
<p>Azure&nbsp;Pipelines -- Digital Factory Shanghai Team</p>
</li>
</ol>
</td>
<td>&nbsp;</td>
</tr>
<tr class="even">
<td>
<p>May 2021,&nbsp;V 0.2, Revision of the Guideline</p>
<p>New sections added and existing sub-sections enhanced/updated</p>
<ul>
<li>
<p>Security Section&nbsp;(added&nbsp;by&nbsp;Security Advisory &amp; Standards team)</p>
<blockquote>
<p>6. Application Security</p>
</blockquote>
</li>
</ul>
<ul>
<li>
<p>Dashboard sub-section&nbsp;</p>
<blockquote>
<p>7. Azure DevOps Dashboard</p>
</blockquote>
</li>
</ul>
<ul>
<li>
<p>Monitoring Section&nbsp;</p>
<blockquote>
<p>8. Monitoring</p>
</blockquote>
</li>
</ul>
<ul>
<li>
<p>Sub-section 2.3 Project settings with authorization concept (enhanced)</p>
</li>
<li>
<p>Replace real project information with Test project&nbsp;(updated)</p>
</li>
</ul>
</td>
<td>&nbsp;</td>
</tr>
<tr class="odd">
<td>
<p>July 2021,&nbsp;V 1.0, Revision of the Guideline</p>
<ul>
<li>
<p>Location of document centralized - DevOps Team</p>
</li>
</ul>
<ul>
<li>
<p>Update sections - Digital Factory Shanghai Team</p>
<p>4.1.3. Commit Message</p>
<p>4.2.5. Support of multiple product line</p>
<p>4.3. Trunk based development</p>
</li>
</ul>
<ul>
<li>
<p>Review obsolete information &ndash; DevOps Team</p>
</li>
</ul>
</td>
<td>&nbsp;</td>
</tr>
<tr class="odd">
<td>
<p>August&nbsp;2022,&nbsp;V 1.1,&nbsp;Revision of the Guideline</p>
<ul>
<li>
<p>Review obsolete information &ndash; DevOps Team</p>
</li>
</ul>
</td>
<tr class="odd">
<td>
<p>November&nbsp;2022,&nbsp;V 1.2,&nbsp;Revision of the Guideline</p>
<ul>
<li>
<p>Update security information &ndash; DevOps Team</p>
</li>
</ul>
</td>
<td>&nbsp;</td>
</tr>
<tr class="odd">
<td>
<p>August&nbsp;2023,&nbsp;V 1.3,&nbsp;Revision of the Guideline</p>
<ul>
<li>
<p>Review obsolete information &ndash; DevOps Team</p>
</li>
</ul>
</td>
<td>&nbsp;</td>
</tr>
<tr class="odd">
<td>
<p>November&nbsp;2023,&nbsp;V 1.4,&nbsp;Revision of the Guideline</p>
<ul>
<li>
<p>Update external links &ndash; DevOps Team</p>
</li>
</ul>
</td>
<td>&nbsp;</td>
</tr>
</tbody>
</table>