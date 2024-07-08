# Compute at Google Cloud Platform

!!! info
    A Virtual Machine is the least preferred way to host an application in the cloud, as it is IaaS. It causes most overhead on maintaining and securing the VM. Please consider other options first and only use virtual machines for applications which you cannot deploy in a container, cloud run, app engine or Kubernetes cluster.

## Supported OS

Following image families are currently supported:

* Linux 
  - Debian - 10,11
  - RHEL - 7
  - Rocky
  - Ubuntu - 22.04.LTS
* Windows 
  - Windows Server - 2019,2022
* MS Sql
  - MS Sql 2019 Standard on Win 2019 (sql-2019-standard-windows-2019-dc-v20230809)

You might require other OS images for PaaS-specific runtimes (Cloud Dataproc, GKE). Those need to be allowlisted per discussion with Landing Zone team. Please reacht out to us via the [Cloud Portal](https://cloudportal.henkelgroup.cloud/#/) and open a request for implementation.

## Compute Engine - OS Image Governance

Platform/Security team restrict users so that they can create boot disks/VMs only from images that are produced by compute image factory which in turn are approved images that meets Henkel's policy or security requirements.
This governance control is enforced via GCP organization policy constraint "Trusted image projects(compute.trustedImageProjects)" that allows users to create persistent disks/VMs only from images in specific projects i.e. compute image factory projects - hmcp-lzi-img-prj-non-prod-h and hmcp-lzi-img-prj-prod-h

## Management

Henkel Global Infrastructure teams reserve the right to obtain access to the machines, install additional software (OS config agent, endpoints, monitoring agents) and run automation against it to fulfil operational or security-related tasks.

## Compute Engine Access

In order to SSH/RDP a machine, you need to have a firewall ingress rule into your subnet using an [IAP tunnel](https://cloud.google.com/iap/docs/using-tcp-forwarding). 
You connect to the machine using [OS Login](https://cloud.google.com/compute/docs/oslogin) by default.
If there is no rule, you might not be able to use the `gcloud compute ssh` or `gcloud compute start-iap-tunnel` command on your local client. Also the [IAP Desktop](https://github.com/GoogleCloudPlatform/iap-desktop) will not work.

Using RDP/SSH from Henkel WAN does only work after AD joining. Once the machine is registered on Henkel AD, you should be also able to use the hostname and regular RDP access.

## IAM Permissions

In addition, you need IAM permissions for the `OS Login` and the `IAP-Secured Tunnel User` on the project. Please request that from the Landing Zone team during evaluation. Windows users can also use the IAP Desktop to connect. For IAP, you need to have an incoming firewall rule for IAP being opened (this is preapproved by Cloud Security)

## Joining machines to AD

By default, Henkel Windows Virtual Machines shall *not* be joined to henkelgroup.net Active Directory. If that is required, the AD string is `OU=servers,OU=GCP,OU=Units,DC=henkelgroup,DC=net` and it will apply GPO policies for the VM. Only named Henkel t1 admin users can join virtual machines and this is a task performed by the global operations team.

Once they are joined, usually RDP access is also possible using the hostname (*not GCE instance name*).

Hint: Once joined, the group policies will apply and enforce security settings on the VM.

## Golden Images

For Compute Engine (Virtual Machine) images, HMCP will enforce you to use hardened and standardized Henkel images for any application deployment. Therefore, Compute Engine custom image must be used. This base image will have GPO policies enforced for and additional hardening by using Ansible playbooks on top.

* The Henkel custom image will have following components activated:
  * Endpoint Security (Crowdstrike Falcon agent)
  * Henkel Proxy
  * Henkel Custom CA
  * (deprecated) use of a CIS hardened image
* The organization policy will disallow you to deploy a VM that is not of image family type from henkel

## Licensing

By default, you are using the pay as you go model for Windows licenses, unless 
 - The virtual machine has been migrated via lift and shift approach (No custom image or premium image)
 - The virtual machine is runnign on Sole Tenant Node on GCP. 
 - Windows licesne on VM is activated by the Henkel KMS server.

## Backup 

Henkels, opinionated implementation, of GCP Backup and DR Service stores backup data in its original, application-readable format, resulting in many workloads being made available directly from long-term backup storage with no need for time-consuming data movement or translation. 
It supports Google Cloud VMs (Compute Engine and VMware Engine), on-premises VMware VMs, file systems, and databases such as SAP HANA, Oracle, Microsoft SQL Server, IBM Db2, MySQL, MariaDB, PostgreSQL, SAP ASE, SAP MaxDB, SAP IQ, and MongoDB.


**How Backup works (VM):**

If you are only protecting the entire VM or a subset of its disks, then the Backup and DR agent is not required (Agentless).

Define Backup Behaviour via Backup Config Yaml - Find, below an example Backup ![example Backup Config here](../images/../../images/gcp/backupConfigTF.png)



- **Backup Plan**:
  - How often data is backed up
  - How long to retain data
  - Where to store data

- **Backup Template**:
  - Control the frequency and retention of data
  - Enable data tiering and replication

- **Geography**:
  - Geographical GCP zone of VMs

- **apply_to**:
  - Instances that shall be targeted and backed up


**How Backup Works (Applications)**

To utilize the Backup feature on an Application, for example a SQL Database,      the Backup And DR Agent is utilized by the Platform Team. The Agent enables you to efficiently capture data from production applications in an incremental-forever fashion and provides the application awareness at the time of recovery.

The agent is installed on application hosts where applications, to be protected, reside.
To do this in an automated way use startup scripts provided by the platform team. 

Set metadata:
 
{
"windows-startup-script-url":"gs://hnk-hmcp-share-ad-auto-de-prj-dpo/windows/Invoke-StartupScripts.ps1",
    
backupagent: true
}

on the VM instance, via console or terraform configuration (supported for Windows, Linux coming soon).

After successfully installing agent, maschines can be targeted via ![Backup Config.yaml](../images/../../images/gcp/backupConfigTF.png) and input parameters i.e. apply_to.

Please be aware, the follwing is not governed by Platform team:

* Agent installation on the VMs.
* Running/executing Backup jobs.
* Backup Schedule configuration - new/changes/updates
* Monitoring Backup jobs.


## VM Patching

Google Cloud Platform (GCP) offers a [Patch Management system](https://cloud.google.com/compute/docs/os-patch-management) for keeping your Compute Engine VM instances up to date with essential operating system and software patches. The system comprises two key components:

**How Patch Works:**

To utilize the Patch feature, the OS Config API and the OS Config agent are enforced centrally by the Platform Team. The OS Config service enables patch management, while the agent utilizes the update mechanism for each OS to apply patches.


To utilize the Patch feature, Platform Team has centrally enforced below:

* OS Config API and the OS Config agent in the hardened images produced by Compute Image Factory. The OS Config service enables patch management, while the       agent   utilizes the update mechanism for each OS to apply patches.

* Project level metadata value: ![create_os_patch TRUE"]((../images/../../images/gcp/create_os_patch_template_example.png))

**Schedule** 

Users get the ability to define the Patch Deployment Schedule as an input in the project factory project definition file (yaml). Patch Deployment Schedule is a Project level construct, It    applies to all the VMs running inside the project.
      Here is a ![Example project-template.yaml](../images/../../images/gcp/patch_deployment_schedule_parameters.png)


**Please be aware, the following is not governed by the Platform Team:**

* OS Config agent installation on the VMs (VMs which are not using Compute Image factory images) 
* Running/executing Patch jobs. 
* Patch Deployment Schedule configuration - new/changes/updates
* Monitoring Patch jobs 
* Rebooting VMs after Patch job application 


You can [view patch summary information for your VMs](https://cloud.google.com/compute/docs/os-patch-management/view-patch-summary) using the Patch dashboard on the Google Cloud console or by checking patch jobs' status through various methods.

Patch Dashboard:

The [Patch dashboard in the Google Cloud console provides an overview of the patch compliance and operating systems of your VMs](https://console.cloud.google.com/compute/patch?_ga=2.238762758.747909812.1697536737-924623280.1689602451). It categorizes VMs by operating system and compliance status (Critical, Important/Security, Other, Up-to-date). For unsupported SUSE Enterprise Linux Server (SLES) OSs, patch compliance reporting isn't available, and these VMs fall into the 'No data' category on the dashboard.

## Networking

A VM sits in the assigned subnet and for communications, need to have firewall rules being opened. This is allowed and disallows based on Merge Requests in GitLab and taken care of by Network Security team.

## Internet Ingress

A public IP must not be attached to the NIC. Instead, you must use a load balancer and Cloud Armor policy to protect the VM for internet ingress.

## Good practices

Deploy a separate data disk that is mounted to the Vm, so that not everything sits on the boot disk and system vs. data can be separated. Install your software also on the data disk.
