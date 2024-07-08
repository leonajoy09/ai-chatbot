# DNS domain name concept

## Principles

Private DNS names should be easy to remember and not overcomplicate it - if it's easier to remember the IP, you're doing it wrong!

## Naming convention

The top level domain is: **henkelgroup.io**

For DNS resolution, we use following convention: `<Environment>.<Project Name>.<domainname>.<icanntld>`

Rules:

- The subdomain should not have a reference to technology ("cloud", "cluster", "azure")
- Multi-env readiness: the naming works well for distinguishing prd, staging, test and so on
- Tree depth: limit the depth of the names to four, maximum of **five**. For example, a.b.c.d.e.f.g.mydomain.tld would be too long and hard to handle

- The project should be your subdomain
- Under the subdomain, use this naming convention:
  - start with the environment for dev and test as first prefix. For production, use **no prefix**
  - if you have several microservices, put them as secondary prefix

## Examples

- Development - dev.somartsmart.henkelgroup.io
- QA - qa.somartsmart.henkelgroup.io
- UAT- uat.somartsmart.henkelgroup.io
- Production - somartsmart.henkelgroup.io

| Domain levels | Name | Explanation |
|-|-|-|
| Top Level Domain name | io| .io is a generic top-level domain (gTLD) |
| Second Level Domain name | henkelgroup | Our registered domain (TLD)|
| Third Level Domain name | Project Name | Indicates Project Name. This should not exceed 15 characters. If exceeds, meaningfully shorten to cap it in this range or use a meaningful 3 letter. e.g. dev.hdf.henkelgroup.io |
| Fourth Level Domain name | Environment | Indicates Enviroments of the Application. The Environments in general could be dev/qa/uat, Important - This is not applicable if the domain is intended for Internal production applications |
|  Fifth Level Domain name | Optional: Use this when multiple versions of same environment exists. | Sample use case of fifth level domain: Content Management and Content Delivery of a CRM application exists. e.g. cd.dev.\<Project Name\>.henkelgroup.io, cm.dev.\<Project Name\>.henkelgroup.io |

## List of domains in use

|     3rd-Level Domain            |     Description                                                                   |
|---------------------------------|-----------------------------------------------------------------------------------|
|     dbp.henkelgroup.io          |     Projects related/subordinated to Digital Business Platform (DBP).           |
|     hdf.henkelgroup.io          |     Projects related/subordinated to Henkel Data   Foundation (HDF).              |
|     api.henkelgroup.io          |     Services related to core business api-layer.                                  |
|     swfactory.henkelgroup.io    |     Services/applications related to CI/CD-Chain of   our Software Factory.       |
|     ops.henkelgroup.io          |     Services/applications related to productive   operations. E.g. monitoring.    |