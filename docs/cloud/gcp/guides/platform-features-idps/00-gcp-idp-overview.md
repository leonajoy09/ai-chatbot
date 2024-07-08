## IDP Overview

### The Era of Platforms
The concept of a platform began to gain traction with the increasing adoption of cloud technologies as well as the growing complexity of applications. The need for a platform arose to bridge the gap between developers(DevOps engineers, SREs etc.) and operations teams. But what exactly is a platform?

A platform is an interface for developers that enables access to underlying infrastructure technologies & abstractions such as a VM, a database, FW rules, IAM roles, Backup config etc. Its primary goal is to abstract away the complexities of various tools, and services and provide a unified platform for developers. This way a platform empowers developers to focus on their core expertise rather than focusing on deep expertise in all of the underlying layers.  

![Platform Overview](../../../images/networking-shared-vpc.png) 

### What is an Internal Developer Platform (IDP)?
An Internal Developer Platform (IDP) is built by a platform team to build golden paths and enable developer self-service. Here "deveoper" is referred in the context of DevOps and SRE principle. An IDP consists of many different techs and tools, glued together in a way that lowers cognitive load on developers without abstracting away context and underlying technologies. Following best practices, platform teams treat their platform as a product and build it based on user research, maintain and continuously improve it.  

On GCP, IDPs are configured/setup in the form of Factories e.g. Project Factory, IAM Factory, FW Factory etc.  

### How Internal Developer Platforms are used by Platform, Ops or DevOps, SRE teams  
The platform team primarily builds, runs, configures and maintains the IDP. Platform team building IDPs concentrate on standardization by design, infrastructure, workflow-optimization and configure the IDP to automate recurring or repetitive tasks, such as spinning up resources or environments. The platform team also sets the baseline for dynamic configuration management to avoid unstructured scripting which would lead to excessive maintenance time.  

### Refernces
- [Internal Developer Platform](https://internaldeveloperplatform.org/what-is-an-internal-developer-platform/ )  
- [Platform Engineering 101](https://www.infracloud.io/blogs/platform-engineering-101/)
