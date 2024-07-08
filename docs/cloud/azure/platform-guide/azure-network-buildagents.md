# Azure DevOps Build Agents

Build agents are essential for building and deploying source code and infrastructure code through Azure DevOps. Microsoft offers several images that can be used with the Microsoft-hosted build agents. These images have many advantages, such as having a large number of tools preinstalled and being ready to use.

Azure DevOps built-in build agent have the limitation that they cannot access resources inside Virtual Networks such as Azure Resources like a Storage Account which is vNET integrated. Requiring access to virtual network resources is a common use case e.g. for Terraform Deployment. 

## Self-Hosted Build Agents

To overcome this limitation, a self-hosted build agent is provided as part of a Landing Zone, along with the Virtual Network. The build agent is registered as an agent pool in Azure DevOps and can be referenced by any pipeline in the DevOps project.

The Landing Zone platform provides two options for build agents:

- A slim ubuntu image
- Image based from Microsoft build agents

### Basic ubuntu build agents

The agents are based on an [Ubuntu Server 20.04 LTS](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/canonical.0001-com-ubuntu-server-focal) image running in a Virtual Machine Scale Set.

The following tools have been installed on top of the tools already present in the base image:

- zip
- unzip
- git
- wget
- Azure CLI
- PowerShell
- Docker

If other tools are needed, they can be installed by running commands such as `apt install [application]` inside a pipeline that uses the agent.

### Microsoft image based build agent

These agents are based on public build agent runner images maintained and [published by Microsoft](https://github.com/actions/runner-images). They provide the same tools and packages which are available on the native Azure DevOps build agents. The full list of available packages can be seen here [Ubuntu 22.04](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2204-Readme.md).
A new version of the build agent based on the Microsoft runners are built nightly when Microsoft has released a new image version.

## Proposed Usage of Build Agents

The Microsoft-hosted agents have compilers and tools for many different languages (C#, Java, etc.) already installed and configured. Therefore, it is recommended to use them for building and packaging the application, as they require less work for configuration and maintenance. Moreover, the Microsoft-hosted agents are usually more available than the self-hosted agents, which can take some time to be ready.

The self-hosted agents can be used for deploying the packaged application to the service where it should run, such as an App Service, as they have connectivity inside the Virtual Network, which the Microsoft-hosted agents lack.
