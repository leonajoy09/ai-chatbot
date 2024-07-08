## GCP Hierarchical Firewall factory

# Introduction 
This repository contains the yaml definition files used in [csr-security-henkel](https://source.cloud.google.com/hmcp-lzi-seedproj-henkel/csr-security-henkel) repo to deploy hierarchical firewall policies.

# Repository structure
The deployment of the [csr-security-henkel](https://source.cloud.google.com/hmcp-lzi-seedproj-henkel/csr-security-henkel) repository depends on the structure folder of this repository. Therefore it is important to keep and maintain the hierarchy of folder structure.

## Structure
The structure has the following the pattern: 

    <Henkel_Organization>/<Terraform_Action>/<File_name>.yaml

<Henkel_Organization>: is the name of organization in GCP.
 * henkeltestcom
 * henkelcom

<File_name> include three yaml files:
* cidrs.yaml
* rules.yaml
* associates.yaml

Description on how to define yaml files, can be found in comment section of each file.

The <Terraform_Action> can be :
* org: to deploy terraform
* org-plan: to plan terraform

## Pipeline
hierarchical firewall policies deployment pipeline is initiated by committing changes in relevant <Terraform_Action> folder.

## Current rules

### GCP Hierarchical Firewall Rules

This repository contains the set of Hierarchical Firewall Rules that are used to manage traffic flow within our Google Cloud Platform (GCP) organisation. These filewall rules are applied on the Henkel organization level, teams do not need to request subnet level rules for below rules because these rules will be inherited automatically to all the projects.

#### Egress Rules
Egress rules manage outbound traffic.

1. **allow-crowdstrike-tcp-egress-rule**: This rule permits traffic from our VMs to the Crowdstrike public IP range on TCP port 443, typically used for sending security data to Crowdstrike for analysis.

2. **allow-ad-dns-smb-tcp-egress-rule**: Allows outbound traffic from GCP to Active Directory (AD), Domain Name System (DNS), and Server Message Block (SMB) services on specified TCP ports. It's applied on several specified VPC networks.

3. **allow-gcp-henkel-kms-tcp-egress-rule**: Allows outbound traffic from Henkel Key Management Service (KMS) to VMs on TCP port 1688.

4. **allow-gcp-google-kms-tcp-egress-rule**: Allows outbound traffic from Google Key Management Service (KMS) to VMs on TCP port 1688.

#### Ingress Rules
Ingress rules manage inbound traffic.

1. **allow-iap-tcp-ingress-rule**: Allows inbound Secure Shell (SSH) and Remote Desktop Protocol (RDP) traffic from users' laptops to specified VMs on TCP ports 22 and 3389, typically for remote access to VMs.

2. **allow-zscaler-tcp-udp-ingress-rule**: Allows inbound traffic from Zscaler, a cloud security platform, to GCP on all TCP, UDP and ICMP ports.

3. **allow-pulse-tcp-udp-ingress-rule**: Allows inbound traffic from Pulse Secure, a secure access solution for people, devices, things and services, to GCP on all TCP, UDP and ICMP ports.

4. **allow-os-config-vm-tcp--ingress-rule**: Allows inbound traffic from OS Agent VM Host to GCP on TCP ports 5985 and 5986, typically for remote management of VMs.

All the above rules have logging enabled to keep track of how these rules are being used and for troubleshooting purposes.

## Process for requesting exceptions and new policies

To enhance our Hierarchical Firewall Policy and ensure it adapts to our evolving needs, we have established a process that allows users to propose new rules or exceptions. If you need to request an exception to the current firewall rules, please follow the steps below:

### How to Submit a Merge Request

1. **Clone the Repository**: Start by cloning the 
"lz-hierarchical-fw-policy-factory-config-henkel" repository which contains the hierarchical firewall policy firewall rules. This creates a personal/local copy for you to work on.

2. **Create Your Branch**: In your cloned local repository, create a new branch for your proposed changes. It's best to name the branch in a way that reflects the nature of the update or exception and starts MR name should start with 'feature/' keyword.

3. **Update the Rules**: Make the necessary additions or modifications to the firewall rules within your branch. Please ensure your changes are clear and documented.

   - **environments/henkelcom/org/cidrs.yaml**: This file contains the CIDR ranges that are part of the Hierarchical Firewall Policies.
   - **environments/henkelcom/org/rules.yaml**: The `rules.yaml` file holds the actual Hierarchical Firewall rules, detailing aspects such as CIDR ranges defined in `cidrs.yaml`, direction, ports, and target resources of the firewall rules.
   - **environments/henkelcom/org/associates.yaml**: This file, `associates.yaml`, manages the associations of rules defined in `rules.yaml`. Each rule created in the `rules.yaml` file must be linked to the Hierarchical firewall policy `allow-ingress-egress-hierarchical-policy` in `associates.yaml`.

4. **Commit Your Changes**: After making your updates, commit the changes to your local branch. Include a detailed commit message explaining the changes and the reasons for them. And then push to the remote.

5. **Create the Merge Request**: Once your changes are committed and pushed to remote, create a merge request to merge the changes from your feature branch into the main branch. In the MR description, provide a detailed rationale for your proposed changes and any additional context that might help in the review process.

6. **Review Process**: The MR will be reviewed by designated approvers. For the initial phase, the MR approvers are:
   - Siddharth Kamal <siddharth.kamal@henkel.com>
   - Omkar O Sonawane <omkar.o.sonawane@henkel.com>
   - dxS Edge security team (Gitlab group - hmcp-dxs-edge-security)

   So, add any of them as a MR reviewer while raising the MR.
   They will review the changes, possibly ask for modifications, and finally approve or reject the MR based on its adherence to our security standards and business needs.

### Approval and Merging

If the MR is approved, you will be allow to merge into the main branch, and the new rules will be implemented accordingly. If rejected, feedback will be provided, and you may be asked to make further revisions.

## Contact

For any issues or questions regarding the merge request process or firewall rules, please contact the administrator at `mail-DL-dxS-CloudSecurity <mail-DL-dxS-CloudSecurity@group.henkel.com>`.

Thank you for helping us maintain and improve our firewall security protocols!