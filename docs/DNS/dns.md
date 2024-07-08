# Welcome to Henkel Private DNS

DNS records were created manually with SNOW. In  context of IBS' ambitions to expand digital excellence and improving faster cloud deployments.

With Henkel Private DNS,we offer automated management of DNS-Records. This allows for defining all aspects of a system in one place (codebase) and resolves the shortcoming mentioned before.

Examples for use-cases in which dynamic, API-Driven DNS is particularly useful are: custom software development, analytics/ml and complex products with several staging areas and lots of reachable microservices.

In these contexts, there is ad-hoc and short-lived demand for DNS-Records. As systems and environments are spin up and down as part of development processes, IP's and records change more frequently than in context of productive operations and static DNS resolution.

In order to still benefit from DNS, automated processes are required which instantly adapt to changing environments.

Another example is container orchestration (based on Docker Compose/Swarm, Kubernetes and such). Typically, one wants to benefit from the IPAM provided by cloud- or platform-providers and not deal with static IP assignments.

Subsequently, we created this solution for the mentioned requirements.

The solution begins with hybrid deployments on Azure. 

## Outlook 

- Extension to cover AWS and/or vSphere too. 
- Extend to public Henkel-based DNS 
- Offer a self-service URL shortening service.


## Documentation structure:

The following section describes the different documentation artifacts, where they should be stored and their general structures.

### Project documentation 
#### Architecture and Manuals
Manuals as well as architecture principles should be documented along with their drafts in this Wiki. See the Architecture article in the *Templates* section for detailed information and examples of the structure.

#### Code artifact documentations and READMEs
Usage explanations and READMEs of the project and its (sub) services will be documented in the git repositories itself using Mardown notation to efficiently write down development thoughts side by side with the actual code. See *README* article under *Templates* for detailed information.

### User and Consumer documentation 
#### HowTo
General HowTos will be stored in this Wiki under the *howto* section.

#### Release Notes
Release Notes will be published in the *Release Notes* section. They will be collected in the end of each sprint by reviewing closed Tickets from the Azure DevOps Board that are tagged with the *Release Notes* tag. Each user story has to be assessed for its customer relevance before adding its business value with one sentence to the Release Notes page. 

### Operational manual (including procedures e.g. how to restart a cluster)
Operational manuals that are only relevant for the ADD team will not be shared with the customer. Thus their documentation articles will be stored in an internal Wiki. (DevOps)

