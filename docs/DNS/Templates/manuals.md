# General Structure
Used for the documentation of User and Customer Manuals.

## Problem Description
Short Descriptions help the reader to get a quick overview over the topic and support the process of quick evaluation wether an article might be helpful or not. It should describe the problem that this article is going to resolve or at least assist on.

## Prerequisities
Make sure to mention all prerequisities at the beginning of the article (e.g. Visual Studio Code needs to be installed, make sure you have a vpn connection to Henkel, etc.)

## Content
The content should always be descriptive and helpful for the reader. Try not to use uncommon, project internal abbreviations without declaring them at some point. Clearly declare the steps to be taken in a list of consecutive tasks. If there is additional understanding needed, reference further (official or internal) articles (e.g. from MSDN, Kubernetes, etc.).
Ensure that the articles are up to date after deploying changes that affect the handling or the described process.

## Add Tags
Tags optimize searches and help developers to quickly find documentations of the current state of implementation.

# Example

---

# [HowTo] Do something very special 

# Problem Description
A brief overview of the topic, to enable a reader to evaluate wether this article is relevant for him or not.

# Prerequisities
Before starting the steps mentioned beyond, make sure that you have
- a git client installed
- Visual Studio Code installed
- a running AKS cluster

# (Depending on the project) Steps
1. Check something by performing the first step
2. Do something on that check
3. and so on...

##### Tags: e.g. kubernetes, iac, infrastructure, concept, networking, aks, restart

