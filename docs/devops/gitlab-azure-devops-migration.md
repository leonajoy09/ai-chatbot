#Migration from GitLab to Azure DevOps

The dx ExCom decision from July 2020 states that Azure Devops is our new standard system for Version Control.
All new projects are expected to be created in Azure DevOps and all existing GitLab projects must be migrated.

## FAQ
### Why is the creation of new projects deactivated?
To meet the goal of migrating from GitLab to Azure DevOps, the creation of new projects in GitLab has been disabled.

### Is GitLab decommisioned?
Yes, individual migration scenarios were communicated and GitLab system has already been decommissioned.  

### I want to create a GitLab Project, what do I do now?
If you want to create a new project or are planning to do so in the future, please use Azure DevOps. You can find more details on how to request it in the [Request Azure Devops Doc](https://docs.henkelgroup.cloud/howto/request-azuredo/).

### I need help with setting up a Microsoft Azure DevOps project.
To get help creating a new project, please visit the [Microsoft Azure DevOps FAQ](https://docs.henkelgroup.cloud/devops/azure-devops-and-github-faq/).

### How to migrate Gitlab Repos to Azure DevOps?

This guide describes how to migrate any Git repository (like hosted on Henkel GitLab, for example) to Azure DevOps Repository.

Basically, the steps are:

1. Create a new repo on your Azure DevOps project.
2. Mirror clone the old repo from its current location to your local workstation:  

        git clone --mirror git@your-gitlab-site.com:khalih/my-repo.git
        
3. Mirror push to the new repo on GitHub with pre-commit hooks skipped:

        # Change into newly created repo directory
        $ cd ~/my-repo.git
        
        # Push to GitHub using the `--mirror` option. The `--no-verify`
        # option skips any hooks.
        $ git push --no-verify --mirror git@ssh.dev.azure.com:v3/myorganisation/demoproject/demorepo

Make sure to adapt the above code snippet with your specific user info.

That's it!