# Technology Roadmap Kyndryl and Henkel

## Description

Kyndryl and Henkel periodically agree on the so-called **Technology Roadmap** (sometimes also referred to as Consolidated Software Components). It will be updated and published here three times a year, in the months of January, May and September.

The current release of the Technology Roadmap:

* [Download Technology Roadmap 2024 Phase II_KYNDRYL HENKEL PUBLIC.xlsx](../files/Technology_Roadmap_2024_Phase_II_KYNDRYL_HENKEL_PUBLIC.xlsx) (updated 2024-06-25, CURRENT, public version, can be shared with externals)

The Technology Roadmap contains all software components (OS, middleware, applications, runtimes, etc.) and their appropriate statuses. The statuses explain whether a component can be deployed, can be maintained, etc.

| Status | Description | Meaning |
| --- | --- | --- |
| <mark style="padding: 0.5em 0em; background-color: #00b0f0;">Emerging</mark> | Upcoming Vendor Release | ​Can be deployed on exceptional basis. **Not fully supported** by Kyndryl (yet). | 
| <mark style="padding: 0.5em 0em; background-color: #57d729;">Invest</mark> | ​New Vendor Release Level (Maintenance & Support) | Default for new deployments. Is **fully supported** by Kyndryl. |
| <mark style="padding: 0.5em 0em; background-color: #ffff99;">​Maintain</mark> | ​N-1 Release Level (Maintenance & Support) | **​Should not be used for new** deployments if an "INVEST" variant of the same component exists. Is **fully supported**. | 
| <mark style="padding: 0.5em 0em; background-color: #ffc000;">​Migrate</mark> | ​N-2 Release Level (Maintenance & extended Support) | **​Has to be upgraded** to a higher and supported release or replaced completely. Not available for new deployments. | 
| <mark style="padding: 0.5em 0em; background-color: #ffcc99;">​Disinvest</mark> | ​&gt;N-2 Release Level; Active Phase-Out | ​Not available for new or existing deployments. | 
| <mark style="padding: 0.5em 0em; background-color: #ffcc99;">​Security&nbsp;Fixes&nbsp;Only</mark> | ​Free-of-charge support for security bug fixes only, additional support options dependent on vendor | Reduced scope for free-of-charge support from vendor. No functional bug fixes available. Not available for new deployments. Upgrade recommended. | 
| <mark style="padding: 0.5em 0em; background-color: #ff0000; color: #fff;">​Unsupported</mark> | ​Out of Vendor Support (End of Support / EoS) | **Unsupported** solution. Will not receive operational support via Kyndryl DC. Will require exceptional approval for continuing operation. | 
| <mark style="padding: 0.5em 0em; background-color: #ffc7ce;">​Tolerated</mark> | ​Any Release Level | ​Not strategic but compliant. Will receive operational support via Kyndryl DC. | 
| <mark style="padding: 0.5em 0em; background-color: #7030a0; color: #fff;">​Restricted</mark> | ​Any of the above, but restrictions apply | **​Unwanted** solution. Cannot be deployed without exceptional approval by the Data Center Architects of Kyndryl and Henkel. | 

If you feel something is missing or wrongly stated in the Technology Roadmap, please contact Henkel Datacenter Architecture team.

## Motivation

In order to have the most homogeneous architecture within the data center, Kyndryl & Henkel agree on a set of "standard" components, which can be deployed. This ensures a lower overall complexity and therefore a lower TCO.
Additionally, the needs for updates (in case of shortcomings or end of support timings) can be identified proactively on a long-term basis.

## Implication

Projects, initiatives and MSOs have to align their systems to the components listed in the Technology Roadmap.
They have to plan the respective upgrades or replacements of the appropriate components in time and take care that it will be carried out.