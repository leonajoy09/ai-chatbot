# Introduction
Azure is Microsoft's cloud computing platform. Henkel started to use Azure a couple of years ago as its first public cloud provider. In 2022, we decided to restructure how we use Azure at Henkel from both organizational and technical perspective. In this chapter of the Henkel Cloud Docs, we begin with a short overview of Azure along with links to read on. Afterwards, we describe the environment we provide to support your use case in the cloud and what we expect from you. If cloud computing is entirely new to you, we recommend you to read this blog post as [general introduction to cloud computing](https://www.digitalocean.com/community/tutorials/a-general-introduction-to-cloud-computing).

## Azure Fundamentals
Similar to other public cloud providers, Azure offers a variety of services for different purposes ([full list of Azure services](https://azure.microsoft.com/en-us/products/)). Services include for instance PaaS services like the [Azure App Service](https://azure.microsoft.com/en-us/products/app-service/) for easy deployment of web applications, but also IaaS services like [Virtual Machines](https://azure.microsoft.com/en-us/products/virtual-machines/) or [Virtual Networks](https://azure.microsoft.com/en-us/products/virtual-network/).

Most likely, your use case will require not only one service but a combination of multiple services which interact with each other. Therefore, Azure provides a hierarchy to structure the used services (see figure below). A service is also often called **resource**. Multiple resources can be organized in a **resource group** and multiple resource groups form a **subscription**. Typically, you will get multiple subscriptions from us for your use case so that you can use, for example, one for testing and one for production. Multiple subscriptions can be organized in a **management group**, e.g., to enforce security principles. However, you will not deal with management groups, but only with subscriptions and below. If you want to know more, read the [Azure fundamental concepts](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/fundamental-concepts).

![Hierarchy](../images/../../images/azure/resource-hierarchy.png)

## Azure role-based access control (RBAC)
A crucial part of every IT system is proper access management, i.e., who can access which part and execute which actions. Processes to monitor and verify access attempts are called access control. In this section, we will shortly describe how access control works in Azure so that you are ready to use it.
Azure uses a concept called **role-based access control (RBAC)** which is based on the assignment of roles. It consists of three parts:

1. **Principal**: the entity which should get access. An entity can be a **user**, a **group** of users, a **service principal**, or a **managed identity**. Read this blog post if you want to know more about [service principals and managed identities and their differences](https://devblogs.microsoft.com/devops/demystifying-service-principals-managed-identities/). Users and groups are managed at Henkel via [MyID](https://myid.henkelgroup.net/home.jsf).
2. **Role**: a collection of permissions, e.g., read a resource. Azure provides [a long list of built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles), but it is also possible to define your own roles with a custom set of permissions. It is recommended to use the smallest set of permissions to fulfill the desired task and have no unnecessary permissions. 
3. **Scope**: where the permissions of the role apply to, i.e., a management group, subscription, resource group, or resource. If you choose a scope higher up in the hierarchy, the role assignment will affect more resources because an assigned role is inherited. That is, if you assign a user with a role on subscription level, she will have this role on all resource groups in that subscription and on all resources in those resource groups. Therefore, it is recommended to use the smallest scope possible to avoid granting not needed access to resources.

You can read more about [role-based access control in the Azure documentation](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview) and how we use it at Henkel in the section about [access control](./access.md).