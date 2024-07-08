# Central Terraform Repo FAQ

## What is Central TF Repo?
It is a TF Module Repo in Azure DevOps in HMC (Henkel Managed Cloud) that contains Terraform module for the commonly used Azure Services. Project Teams can easily consume it for the respective Cloud Services 

## Why this is needed, can´t we use the Terraform official Repo ?
This repo is private to Henkel and the modules built here are more of  ´Henkalized´ way in terms of customization by incorporating security best practices and other Henkel Governance standards (e.g. Usage of Golden Images for VM). The usage of Central TF Module also ensures Consistency across various projects 

## Which team in Henkel would be accountable for maintaining Central TF Repo?
The team has not decided or formed yet. It should ideally be a Technical team that expertise in Terraform and aware of Henkel Governance and Standards.

## How Project Teams can get benefit out of it?
Central TF Module is reusable. Project Teams can connect to the required modules by ´sourcing´ it from their own Azure DevOps projects 

## Who all are supposed to contribute Central TF Repo ?
Anybody in Henkel IT Teams who wishes to contribute to Central TF Module

## Do we have business buy-in to build, use and maintain Central TF Repo?
Central Terraform Repo is part of the Hybrid Cloud initiative 

## How do we ensure latest patches in the official TF repo are applied to Central TF Repo?
TBD

## Do we have already have any projects using this ?
Yes, DBP

## Which team drives this initiative ?
Cloud Architecture Team mainly but it may further driven by different cross functional teams

## Does the scope of Central TF Repo is limited only to Microsoft Azure ?
No, all the Cloud providers in Henkel are in  scope
