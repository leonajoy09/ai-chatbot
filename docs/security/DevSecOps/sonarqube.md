# SonarQube

[SonarQube](https://www.sonarqube.org/) is an well-known solution to scan source code to improve code quality and code security with static code analysis or **static application security testing**. SonarQube tries to address both code quality and security, it helps to check the code for conventions and improvements, especially in complexer projects where manual code reviews are not working anymore.

> Not addressing technical debt slows down development and results in a worse, more buggy product.

## Rationale

Why use you it? SonarQube ... 

- helps you to find weaknesses in code before they get into production. The later you detect and fix a bug, the more effort you need to get it out of the system with the release and development cycles. That helps to reduce the costs in software development lifecycle (shift left approach)
- assists you in code quality, especially when you might not be the expert on development and would like to understand where your code can be optimized
- supports many script language such as Python, Node.js, Java, C#, .NET, PHP
- scanning on multiple branches
- pipeline triggers fpr Azure Azure DevOps

At Henkel dx, we have a central instance in place that can be used:

- [Henkel dx SonarQube](https://sonarqube.henkelgroup.cloud/)
- the scans are stored on our servers, nothing is saved at SonarSource / SonarCloud

We are strongly recommending development projects to use it before you commit into the main branch (or production release).

## Integration into Azure DevOps

There are tasks in Azure Devops available. If you use it in a pipeline, you do not need to have a dedicated scanner instance for it. To learn how it works, there is even an Azure DevOps lab to follow along [here](https://azuredevopslabs.com/labs/vstsextend/sonarqube/).

## Get started

!!! info
    Please reach out to the DevSecOps working group via [DevSecOps@henkel.com](mailto:devsecops@henkel.com)

## Usage in henkel dx

Following project successfully use SonarQube to get insights and analyze their code:

- SPARC
- Digital Business Platform

## Lookup Which Quality profiles (like Vulnerabilities) are activated for a Project
- open Project -> "Project Setting" in top right -> Quality Profiles: Lists all activated Quality profiles