# Azure Virtual Machines

```
Microsoft.Compute/virtualMachines/*
```

!!!tip "Choose an SKU matching the Reserved Instances to save cost"

    The most commonly used SKU families are covered by Azure Reservation to save cost. Teams should consider if they can use of the reserved SKUs. Please review the list in the [Azure Reserved Virtual Machine Instances (RI)](../platform-guide/vm/reserved-instances.md).

## Minimum required configuration

### Windows

- Direct Public access inbound is not allowed. Virtual Machines requiring inbound public access must use an [Application Gateway](./application-gateway.md) or [Azure Front Door](./front-door.md) with a Web Application Firewall configured
- The VM must be joined with the Active Directory domain controller for VMs that are not publicly exposed. Utilize the [Platform Domain Join feature](../platform-guide/vm/windows-domain-join.md) to join a VM
- VMs that are publicly exposed, **must not** be domain-joined but should use strong local authentication
- Domain-joined VMs should be onboarded and accessed over Lift. Non-domain joined VMs should be accessed over a Bastion Host
- CrowdStrike must be installed on the VM
- Enforce TLS 1.2 or higher for server or client connectivity
- Enforce End-to-end encryption using [Encryption At Host](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-enable-host-based-encryption-portal). For data-sensitive workloads, Azure Disk Encryption can be utilized too
- VM shall be included in a frequent backup. This can be set up by the Application Team or can opt-in to the [Platform backup feature](../platform-guide/vm/backup.md)
- Windows Event Logs for Audit and System Events should be captured and stored in a Log Analytics Workspace. A Policy will automatically take care of this, see [Azure Monitor Agent](#azure-monitor-agent)
- Virtual Machines should be enrolled into the automated Patch Management feature. Read further [below](#automatic-patching).

### Red Hat Linux

- RedHat Linux VMs must be joined with Active Directory unless they have indirect public exposure. VMs with indirect public exposure, they require to use either SSH authentication (preferred) or username/password
- Non-domain joined VMs should be accessed over a Bastion Host
- Enforce End-to-end encryption using [Encryption At Host](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-enable-host-based-encryption-portal). For data-sensitive workloads, Azure Disk Encryption can be utilized too
- VM shall be included in a frequent backup. This can be set up by the Application Team or can opt-in to the [Platform backup feature](../platform-guide/vm/backup.md)
- CrowdStrike must be installed on the VM
- Linux SysLogs for Audit and System Events should be captured and stored in a Log Analytics Workspace. A Policy will automatically take care of this, see [Azure Monitor Agent](#azure-monitor-agent)
- Virtual Machines should be enrolled into the automated Patch Management feature. Read further [below](#automatic-patching).

### Other Linux distros

!!!info "Linux Virtual Machines is awaiting review"

    Virtual Machines running other distros than Red Hat Linux Enterprise are still a Service Enablement Review despite having been added to the list of approved services. Users should expect that a future review will put forward a configuration baseline and possible policy restrictions. Use the Azure Security baseline as an indicator for what configuration baseline and policies will be applied in the future.

    Contact the dxV Azure Platform Team or dxS Cloud Security Team for further information.

## Accessing a VM over Lift

Windows Virtual Machines which are Domain-joined should be onboarded and accessed to Henkel's PAM platform Lift. Read further on how to onboard to Lift and use Lift on Henkel Sharepoint

- [Introduction to LIFT](https://henkelgroup.sharepoint.com/sites/SharedResponsibility/SitePages/LIFT-Introduction.aspx?source=https%3a//henkelgroup.sharepoint.com/sites/SharedResponsibility/SitePages/Forms/AllPages.aspx)
- [LIFT Onboarding](https://henkelgroup.sharepoint.com/sites/SharedResponsibility/SitePages/LIFT-O.aspx)

## Automatic Patching

!!!tip

    Be aware that Virtual Machines must have the Patch Mode (property `patch_mode`) set to `AutomaticByPlatform` to activate the Patch Management feature. The requirement is enforced by Policy.

All virtual machines are on-boarded automatically to use the Update Management Center feature on Azure to ensure continuous updates of the Operating System and included software. VMs are onboarded automatically by Policies.

Patching is performed in defined schedules. Read more about the Automated Patching feature and configuration hereof at [Automated Patching feature](../platform-guide/vm/vm-patching.md).

## Enforced Policies

### CrowdStrike

{{ display_azure_policies('crowdstrike') }}

### VM Patching

{{ display_azure_policies('vm_patching') }}

### Platform automation

{{ display_azure_policies('vm') }}

### Azure Monitor Agent

The Azure Monitor Agent is used to collect data from the operating system. A policy will try and add the Azure Monitor Agent extension to all Windows and Linux VMs. Several operating systems are supported out of the box, see [list of supported operating systems](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/agents-overview#windows).
When a custom image is used, the policy will still try to add the extension. Machines and appliances that run heavily customized or stripped-down versions of the above distributions and hosted solutions that disallow customization by the user are not supported. Azure Monitor Agents rely on various packages and other baseline functionality that is often removed from such systems, and their installation may require some environmental modifications considered to be disallowed by the appliance vendor.
The logged data can be seen in below table.

|                   | Windows          | Linux                 |
| ----------------- | ---------------- | --------------------- |
| Logged data       | Event logs       | Syslog                |
| Log facilities    | Security, System | auth, authpriv, audit |
| Minimum Log level | Audit, Warning   | Info                  |

## Terraform example

```terraform linenums="1"
--8<-- "templates/vm_windows.tf"
```
