## How do external users access Azure DevOps?

To enable external users (either Business Partners or External Contractors) to access Azure DevOps projects from organizations managed by DevOps team, the Henkel responsible needs to first either invite them as Business Partners (Option 1 below) OR create a Henkel ID in [myID](https://myid.henkelgroup.net/home.jsf) (Option 2). Feel free to contact us by [mail](devops_support@henkel.com) in case
you are in doubt which option to use.

Once the request for the external user has been completed, [Azure DevOps](https://dev.azure.com/henkeldx/) project administrators can add them to their projects (keep in mind that default access level for new users is Stakeholder). 
For detailed info on [myID](https://myid.henkelgroup.net/home.jsf) processes, please contact myID team.
### Option 1: Manage Business Partners

By this, no Henkel internal address or user-ID (Henkel-ID) are created.
Their existing, external E-Mail (eg. from their company) is used to
create a user in the Azure Active Directory service, which enables them
to use services which are connected to this directory, including
Azure DevOps.  
This is usually sufficient when they do not need to access other Henkel internal
systems or infrastructure.  

* Go to [myID](https://myid.henkelgroup.net/home.jsf)
* Go to '*Business Partner Management*' and then to '*Invite Business Partner*'
* Add email address of Business Partner and hit "Next"
* Fill in Business Partner details and hit "Next"
* Confirm all presented details are correct in the summary and hit "Invite"
* The external user receives an email and has to follow all steps required by this invitation
* After this, provide the external users **emails** to DevOps team by [mail](devops_support@henkel.com) and we will add them to the Azure DevOps **organization**. After this is done, you can add the user to your **projects** in
 Azure DevOps. 

* If the user receives "_401 - Uh-oh ..._" error, once more
  navigate to [myID](https://myid.henkelgroup.net/home.jsf) > _Business partner management_ > _Edit Business Partner_, search for the user and hit next.
* Confirm that the Radio button next to "Enable" is selected and the the last working day is still valid.
* If this is already the case, please get in touch with myID and/or AD-support
  teams. If the user was invited in the past with a different email address, a ticket to ServiceNow must be opened to delete the old user ID.
 

### Option 2: Manage External Contractors

By this, a complete Henkel user registration procedure is applied in order
to create this account, including the creation of a Henkel internal E-Mail
and user-ID (Henkel-ID). This must be created for users when they must
be able to access Henkel internal systems, applications and/or network 
rather than just some specific applications.

* Go to [myID](https://myid.henkelgroup.net/home.jsf).
* Go to '*Manage External Contractor*'.
* Go to '*Registration*' and fill in the required fields.

## Why can't I find the users I want to invite to the project even though I am a project administrator for my Azure DevOps project?

The Azure DevOps organizations managed by DevOps team are connected to Azure Active Directory and you can add only email addresses that already exist in the directory. 
If the users you are trying to invite are external collaborators, they first need to be invited in [myID](https://myid.henkelgroup.net/home.jsf). Please see how to invite them in [How do external users access Azure DevOps?](#how-do-external-users-access-azure-devops?).
If you are an external user and a project administrator, searching and inviting other external users to your project might be limited from AAD, therefore a Henkel project administrator will have to invite the external users to project. 
