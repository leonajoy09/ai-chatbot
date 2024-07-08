# Client Setup

This page is to help members using a Henkel managed client device to get started.

## Proxies

Assuming you work within the Henkel Network, you need to set up an outbound proxy if you are inside the Henkel network (VPN) to reach out to the internet.

For git and many other tools, you need to set a HTTP/S proxy to rech the internet.
Use following commands to set this up in bash or in your git client:

The proxy address is: `proxy.henkelgroup.net:80`

For git, it is:

``` bash
git config --global http.proxy 'proxy.henkelgroup.net:80'
git config --global https.proxy 'proxy.henkelgroup.net:80'
```

To unset the proxy:

``` bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## Cloud CLIs

You can install Azure CLI and AWS CLI with administrative permissions. Other approaches with choco (admin) and scoop (non-admin) might work also, but often need modification of your local PATH variables.

## IDE

### Visual Studio Code

[VS Code](https://code.visualstudio.com/) is free of charge and a powerful toolfor development. The large extension base makes it easy to use it with other tools and a variety of programming languages and file formats.

### VS Code extensions

Following extensions might be helpful to you

#### Version Control and Project Switching

- GitLens
- Project Manager
- Markdown All In One
- Visual Studio Live Share

#### Node.js

- NPM
- Npm intellisense

#### Optics and Code Sanity

- ESLint
- Prettier - Code Formatter
- Rainbow CSV
- Beautify
- Night Owl Theme
- Dracula Theme

- Remote WSL (for Windows 10 + Ubuntu)
- Better TOML

#### SAP Cloud Platform Development (CAP & UI5)

- [SAP Cloud Platform core data service pluging for VS Code](https://tools.hana.ondemand.com/#cloud)
- REST Client
- Test Explorer UI
- Mocha Test Explorer
- SQLite
- Blue Phoenix

#### Others

- Microsoft Azure Extension
- HashiCorp Terraform Extension

## VirtualBox

It is a good idea to have a local VM in conjunction with [Hashicorp's Vagrant](https://www.vagrantup.com/) to spin up a virtual environment to test out things before you deploy to cloud.

## KeePass

Do not store passwords in plain text but always use KeePass. Do not use sync features of internet browsers!

## MFA

Use MFA as much as possible. Nowadays with e.g. Microsoft Authenticator, you can authroize using biometric features and just need to confirm logon with another click.

## Local Admin rights

In order to install development tools and CLIs on Windows, you need to obtain Local Admin Rights. Do this via MyID. Once requested, a service agent from Unisys will contact you and install the rights. Usually takes some days, so plan in advance if needed. Do not use the local admin rights to deactivate security and group policies and stick to the rules of CSIS!
