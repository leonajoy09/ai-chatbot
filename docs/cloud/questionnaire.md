# Onboarding checklist

Since we ask new projects questions at initiation stage a lot, here is a compilation of questions you can prepare and think of **before** approaching us for an initial discussion to speed up onboarding. The questions below help you to structure the discussion and allow us to identify areas for cloud ordering and architectural support.

## General

- What is your driver to go into Cloud? Be aware that DC&Cloud team may reject your case and redirect you into another deployment.
- Please provide an initial architecture diagram of your proposed solution.
- Please list all the components that need to be installed and its hardware requirements

## Application architecture

(Only applicable for custom development)

- Which frameworks do you use?
- Which programming language does the solution use?

- Are you able to containerize the application? Can the application work stateless?
- Are you using unit tests to leverage code quality?

## Development & Deployments  

- How do you differentiate between stages, e.g. Development, Test and Production?
- How do you release changes and enhancement to the instances/RGs?
- Where/How do you store your application code and assets? Do you have a branching strategy in place?
- Do you use Infrastructure as code? Where and how do you store Infrastructure as code templates then?
- Do you use build and release (CI/CD) pipelines ? If yes, where do you store your build artifacts?

## Authentication, RBAC and user accesses

- How do you manage access? For what portions of your solution is access needed (e.g. VM access, DB user etc.)
  - How do you authenticate your users? Usually, authentication in Henkel and our applications are done via the Henkel Tenant in Azure AD.
  - Do you have external users? Do you have users that are Azure AD guest users at Henkel?
- If you require authentication, do you require any App registration or admin consent in Azur AD for some services now or in future.
  - Any app registration, admin consent or issue with Azure AD are to be raised to DirectoryServicesTeam@henkel.com
- Do you have application roles in place you need to propagate using Azure AD? Which type of authentication protocol is employed (e.g. SAML, OAuth, OIDC)
- Service principals and App registrations need to be requested (see below)
- You will only get contributor permission on a resource group RG and not to the respective Subscription.

## Network Design

- How do you handle Security Groups/NSGs?
- Do you require outgoing internet access?
- Do you require access to Henkel Data Center ressources?
- Do you need to communicate to other networks (VNets / VPCs) under Henkel Managed Cloud control?
- Do you need private DNS?

## Security

- We must be certain how you intend to apply security e.g. NSG rules, Firewall and monitoring on the interfaces.
- How do you handle application security?
- How do you harden and update the infrastructure?
- Do you need public SSL certificates?
- How do you manage secrets (keys, passwords)?

## Backup

- What are your backup requirements?
  - What is the backup cycle (how often) and retention period (how long)?
- Do you need to replicate data into different regions?

## Availability

- How many users will access your solution?
- Do you foresee any spikes?

## Service Continuity and Responsibilities

## Costs

- Have you taken care of budget and Clarity code?
- Do you know the current costs?
- Are you aware you can make a cost estimation using the calculators from Azure and AWS?
- Please the price calculators
