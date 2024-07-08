# Forward Proxy DC (IBM)

This page gives a brief overview about the new forward proxy server in the IBM datacenter. The forward proxy in the datacenter provides access to external resources for servers and applications hosted in the datacenter based on a whitelist approach. Using this proxy is the preferred way for accessing online resources. Direct communication over the firewall should be avoided and only used when the application / protocol is not capable of using a HTTP based proxy server. Each application has an individual list of destinations it is allowed to access.



!!! note "Quick Start (Getting Access to online resources for an application)"

    * Identify the (AD) service user your application runs as.
    * Identify the destinations your application requires access to.
    * File the request template.
    * Send the request to: [soc@henkel.com](mailto:soc@henkel.com)


## Proxy Features

* HTTP proxy server
* Client authentication using NTLM and Kerberos against Henkel Active Directory
* Client IP based access
* Individual per application access rules
* Unauthenticated access to software repositories 
* Access to common used resources based on Active Directory group memberships
* AD group based authorisation for multiple service users with the same access requirements (self managed group memberships).
* HTTP CONNECT tunnel for non-HTTP connections (e.g. SSH, IMAP, POP3)

## Proxy Access

Access is managed on a per application basis. Each application is identified either by an active directory service account (preferred) or by the servers IP address. Destinations are permitted per destination FQDN/ip and port/service.

## Repository Access

Commonly used software repositories (such as for linux distributions and packages) are freely accessible from all IP addresses of the datacenter that is served by the proxy. In this case IBM Softlayer and DCO/DCS. No special access request is required.

## Office 365 IMAP & POP3 Access

Access to Office 365 IMAP and POP3 mailboxes over the proxy server is granted for members of the AD group: `CORP-ADM-o365-proxy-pop3-imap-allow`

## Security Considerations

* Protection of the service account used for proxy authentication: In case the access permissions to configuration files where the credentials must be configured cannot be restricted, consider requesting a dedicated service account that is only used for proxy authentication.
* Prefer user authentication over IP based access: Independence of IP addresses provides more flexibility regarding horizontal scaling and moving of workload. It is also more secure in scenarios where multiple applications (or components) are hosted on the same server (and thus have the same IP address). Also, it is much easier to keep clean rulesets on a long-term.

## Getting Access

File the request template and send it to: [soc@henkel.com](mailto:soc@henkel.com)



Implementation Guidelines

[SSH/SFTP over Forward Proxy configuration for Linux clients (E.g. RHEL 8)](ssh-sftp-over-forward-proxy.md)

## Upcoming Changes

| Change | Status | 
| --- | --- |
| Migration of intermediate IBM proxy to final IBM proxy | In planning |

## Quick Facts

| Property | Description | 
| --- | --- |
| Proxy Hostname | ibm-proxy-de.henkelgroup.net |
| Proxy Port | 9090 |
| Protocols | HTTP |
| Interims Operations | soc@henkel.com<br /><br />Rene Graf (ext) <rene.graf@henkel.com><br /><br />Christian Huben <christian.huben@henkel.com> |
| URL Whitelisting | Available URLs/FQDNs are managed via Whitelists. So if you require connectivity to the internet /  services on the internet, you need to request that particular Service to be whitelisted **just for your application**. |
| Technology  | Fortigate Explicit Web Proxy<br /> 2 Redundant Instances with 1 Service IP | 
| Authentication | Kerberos, NTLM |
| Auth Backend | Henkel Active Directory |
| Default Services (HTTP) | Ports: 80, 443, 8443, 8080 |
| Default Services (SSH) | Ports: 22 |
| Default Services (IMAP, POP3) | Ports: 993, 995 |
| Served Networks | IBM Softlayer DC<ul><li>193.187.14.0/23</li><li>193.187.22.0/24</li><li>193.187.23.0/24</li><li>193.187.34.0/24</li></ul>IBM DCO/DCS<ul><li>10.175.0.0/16</li></ul>Dev Instances in DigiLab<ul><li>10.6.0.0/16</li></ul> |


## Proxy Overview

| Proxy | Description | 
| --- | --- |
| ato-proxy-de.henkelgroup.net | Operational, Planned for decommissioning for end of September 2020. |
| ibm-proxy-de.henkelgroup.net | Operational, Hypercare |

## Access Request Template

[Access Request Template](../files/prxy_acl_template.xlsx)

## Links

[Latest Version of Request Template on Sharepoint](https://henkelgroup.sharepoint.com/:x:/r/teams/PhoenixDC/Rejuvenation/02-Security/37-Forward-Proxy/ibm-proxy-de_acl/prxy_acl_template.xlsx?d=w84c2ca0d9a7b49f793e26f4e97691c7b&csf=1&web=1&e=PB0rZG)