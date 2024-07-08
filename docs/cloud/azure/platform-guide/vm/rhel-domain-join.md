# Active Directory Domain Join for Red Hat Linux

Red Hat Linux Enterprise (RHEL) Virtual Machines should be joined with Henkel Active Directory and accessed using t1 accounts only. Excluded are indirectly publicly exposed Virtual Machines.

The Henkel Azure Platform supports domain joining a RHEL VM to Henkel Active Directory as a Platform feature through below provided scripts below. They are available for usage or assistance can be requested from the Platform Team.

!!! info "Prerequisites"

    The script assumes that the following prerequisites are met:

    - The VM must be using a RHEL VM of release version 8 or higher
    - No computer or unit with the same name can exist in the domain controller
    - The Virtual Network must be peered with the hub to have connectivity to Henkel's on-premise network, where the domain controller is located. A landing zone can toggle if a Virtual Network should peer with the hub, which is a prerequisite for the domain join to work.

## Running the script

When executing the below commands, a choice to which OU path the VM should be domain joined to should be taken:

- Do choose the OU path `NewWL` when the VM is a new demand. The VM will be joined to the Azure Landing Zone OU path (`AZDC/Servers/NewWL`)
- Do choose the OU path `kyn_mig` when the VM is migrated from Kyndryl. The VM will be joined to the Kyndryl migrated VMs OU path (`AZDC/Servers/kyn_mig`).

!!!info "Case sensitive properties"

    Some properties like domain name (ie. `HENKELGROUP.NET`) and paths are case sensitive in the below script. Please ensure to keep the capitalization when executing the commands

```bash
# 1. Install prerequisuites, e.g. realmd package
sudo dnf install realmd sssd PackageKit -y

# 2. Run domain join command with a privileged domain join user
# - Replace {USER} with priviliged user
# - Replace {PATH} with NewWL or kyn_mig as described above
sudo realm join -U {USER}@HENKELGROUP.NET --computer-ou "OU={PATH};OU=Servers;OU=AZDC;OU=Units;DC=Henkelgroup;DC=Net" henkelgroup.net

# 3. Optionally inspect the realm configuration to verify a succesful domain join
sudo realm list -v

#. 4. Add AD Groups as entitled users to authenticate with the VM
# - Replace {GROUP} with a valid Active Directory group. Members of the group are entitled to log in
sudo realm permit --realm=henkelgroup.net -g {GROUP}
```

After a successful domain join, the VM might require a reboot.
Hereafter the VM can be accessed with Henkel credentials assuming the account is a member of the previously added Active Directory group.

```bash
ssh {T1-ACCOUNT}@HENKELGROUP.NET@{IP-ADDRESS}
```
