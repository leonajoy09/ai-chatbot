# Migration Environment Prerequisites

## Automation Credentials

Create the file `files/credentials.ini` in the ansible repository with the following content:

```
[proxmox_ve_api_digilab]
user = digilab_automation@pve!automation
password = ***redacted***
```

Of course you should use the password from the Data Center Keepass Database.

## Git Branch

As the master branch is protected, you should work in a separate branch. Naming is up to you.

For a git workflow, please follow respective documentation.

Also your branch has to be set up properly and has to be able to push to upstream.

Don't forget to submit the merge request. Once this has been approved you should keep your branch up-to-date.

## Set Vault Password File

Place the vault password in a file and set the ansible environment variable so you do not have to

```
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
```

Of course you should use the password from the Data Center Keepass Database.

## venv

Use the local venv on the management hosts.

Also, the venv should be up-to-date:

```
ansible-playbook mgmthost.yml
```
