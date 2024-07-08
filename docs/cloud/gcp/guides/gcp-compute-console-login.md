# Login into VMs (GCE)

## 1. GCP OS Login

 GCP Projects can only be accessed using Henkel's Azure AD tenant and federation into GCP Cloud Identity. AAD groups get synched to GCP Cloud Identity. IAM Factory then used by users or administrators to request GCP IAM permissions/roles to AAD groups on specific GCP Projects hosting your applications such as GCE instances (VMs).

![asd](../../images/IAMFlowGenericPic.png)

## Lift Access to Domain joined VM (GCE instance)

Domain joined refers to the Server OS and computer object in the Henkelgroup.net domain, Linux or Windows. The computer object is a representation of your GCE instance and ensures that you can access the Operating system as your client computer. If it is not domain-joined please proceed to section "Default VM access in Google Cloud". If unsure please contact your administrator or raise an incident [Incidents](/docs/cloud/cloud-service-mgmt.md).

### Windows OS

From a Henkel identity perspective this is a privileged access that shall happen through T1 Identities using LIFT from dxS PAM team. This procedure works for Windows VMs (GCE instances) which are AD domain joined.

#### Step 1 - Create a T1 identity

- Please create a [T1 Account via MYID](https://henkelgroup.sharepoint.com/sites/SharedResponsibility/SitePages/Quick-Reference-CardSecondary-Identity--Overview.aspx)

- [Add the T1 Account to a new Microsoft Active Directory Group](https://henkelgroup.sharepoint.com/sites/SharedResponsibility/Shared%20Documents/Quick-Reference-Card---How-to-request-and-remove-access-in-myID_43321.pdf?CT=1646908069897&OR=ItemsView) 
![asd](../../images/myID-ManageADGroup1.png)

- Request to add the Microsoft Active Directory Group to your specifc GCE Windows OS as the Windows Local Admin group via Service Now request, assignment group Global.Srvc.IOC_Hybrid_Cloud.(Tipp: use the GCP Project specific Microsoft Active Directory Group as the local admin group).

#### Step 2 - Setup Lift

Only needed if you are new to Henkel Lift. Follow the [Lift Documentation](https://henkelgroup.sharepoint.com/sites/SharedResponsibility/SitePages/LIFT-O.aspx?xsdata=MDV8MDF8fGExYjAwZDlhOWYzMzRmYTQ2ZDFjMDhkYjhlYWUzMGEzfGU4NzAxMDc1MGQ5ZTRlYTE5OTFkNWEwZDExMGE1ZDI5fDB8MHw2MzgyNjA2NTA5OTQ1Mjc1MTZ8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPak01WW1WbE56STVMV0U1TTJZdE5ETmlPQzA1WkRNNUxUUmlaV0ZqTVRobU5UbGhObDg0TXpBME1qTmhNQzAzT0dSaUxUUTVZak10WWpRM1pDMWlPRFJoWXpRM05HUTRaakpBZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVFk1TURRMk9ESTVPRE15T1E9PXw0MDJhMzA5MzljYjY0N2I4MGM0ZjA4ZGI4ZWFlMzBhMXxjYWVjNzFkODg4ZDg0MWFjOWNiOTlmNTU2OTdmZjUxYQ%3D%3D&sdata=djhuMWtPaGNXVWNmZkdSU2VGUHhTYXh3VmFOZU5SRVh0WkswYklwRVlJRT0%3D&ovuser=e8701075-0d9e-4ea1-991d-5a0d110a5d29%2Csimon.vanstiphout%40henkel.com&OR=Teams-HL&CT=1690468306375&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiIyNy8yMzA3MDMwNzMzMCIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D) to setup Lift properly.

### Linux OS

!!! info
     Currently Lift is WiP for domain joined Linux instances.

!!! warning
     Domain joined Linux OS's are currently not fully supported. We are working with the Skywalker Migration Team on a general setup to support henkelgroup.net domain (dxV)

## Default VM access to GCE Instances

The default access in Google to a GCE instance is controlled via IAP that establishes an dedicated connection to your client device. After this IAP connection is arranged, you can use the Google Cloud IAP functionality for the actual [SSH based](https://cloud.google.com/iap/docs/using-tcp-forwarding#tunneling_ssh_connections) login via an shell/putty.

### Step 1 Install IAP

!!! For Windows users:
     Install IAP Desktop onto your client machine, installation file under [here](https://googlecloudplatform.github.io/iap-desktop/install/)

!!! For Mac users:
     Install [gcloud](https://www.youtube.com/watch?v=tzFfdtb33K4) to work with GCP Cloud, [here](https://cloud.google.com/sdk/docs/install-sdk?hl=de#mac). Follow the instructions in the Google handbook to install and initialize the Gcloud tool.

### Step 2 - Access your GCP Windows Server

- Get the daily Lift password on the T1 account in https://Lift/ under the three dots next to the drop down at "Connect" and select copy or view.

![asd](../../images/lift-get-password.png)

!!! For Windows users:
     Start IAP desktop and [connect to your instance](https://googlecloudplatform.github.io/iap-desktop/connect-windows/)

!!! For Mac users:
     Type following to access a machine via
    *gcloud compute start-iap-tunnel YOURSERVERNAMEHERE 3389 --local-host-port=localhost:3389*    
    Then just RDP to localhost with the credentials you'd normally use.

### GCP OS Login and IAP Preparation (Google Cloud Project Admins & Developers)

This step requiresa setup GCP Project.

- For logging into a Compute Engine, [OS Login](https://cloud.google.com/compute/docs/oslogin) is enabled by default. OS Login simplifies SSH access management by linking your Linux user account to your Google identity (henkel.com). It directly ties your Linux user account to a your Google identity so that the same Linux account information is used across all instances in the same project or organization (controlled via IAM role).
- IAP API ```iap.googleapis.com``` is by default enabled on all projects provisioned via Project Factory.
- The firewall rule ```(35.235.240.0/20, SSH-22/RDP-3389)``` required for IAP is already added on the hierarchical fw policy rules therefore no need to request explicitely anymore for any projects.


!!! warning
     Disable OSLogin, via Project Factory, in project setup, when target is a domain joined Linux instance.


#### Step 1 Provision a Azure Active Directory Group

Google Cloud Platform uses groups synced from Azure Entra ID to manage identities. As part of the Project Factory, it is possible to create groups or in certain scenarios use an existing group to gain access to the GCP console.

```
<YOUR-PROJECT-NAME>: 
  name: <YOUR-PROJECT-NAME> 
  app_id: <YOUR-APP-ID>
  groups:
    create_default_groups:
      myid:
        owner: <APP-OWNER-EMAIL>@henkel.com
        admins: 
          - <ADMIN-1-EMAIL>@henkel.com
          - <ADMIN-1-EMAIL>@henkel.com
    existing_groups:
      - <EXISTING-GROUP-NAME>
```

#### Step 2 Assign IAM bindings 

Depending on your use case, please make sure necessary IAM bindings are assigned via [IAM Factory](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/lz-iamfactory-config-henkel/lz-iamfactory-config-henkel)
Find a documentation manual on how to use it [here](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/lz-iamfactory-config-henkel/lz-iamfactory-config-henkel)

| Roles | Grant Level | Description |
|-|-|-|
|IAP-Secured Tunnel User (roles/iap.tunnelResourceAccessor)  | Project or Instance  | Grants access to VM instances secured by IAP.  |
| Compute Instance Admin (v1) (roles/compute.instanceAdmin.v1)  | Project or Instance  | Full control of Compute Engine instances, instance groups, disks, snapshots, and images. Read access to all Compute Engine networking resources.  |
| Compute OS Login (roles/compute.osLogin)  | Project or Instance | Access to log in to a Compute Engine instance as a standard user.  |
| Compute OS Admin Login (roles/compute.osAdminLogin)   | Project or Instance | Access to log in to a Compute Engine instance as an administrator user.  |
| Service Account User (roles/iam.serviceAccountUser)   | Project or Instance | Run operations as the service account. Needs to be granted only if the VM has a service account attached to it which is default in GCP.
