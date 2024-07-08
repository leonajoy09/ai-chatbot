# Azure Storage Account

```
Microsoft.Storage/*
```

## Minimum required configuration

- Default to use Entra ID based authentication
- Disable Shared Access Key
- Enforce minimum TLS version 1.2
- Disable Public Access entirely, use Private Endpoints
- Enforce HTTPS
- Restrictions on SAS, e.g. expiration policies
- Disable anonymous public access to blobs
- Enable Defender for Storage
- Disable Cross-Tenant Replication

## Enforced Policies

{{ display_azure_policies('storage') }}

## Terraform example

!!! info "Policy Exemption is needed for File Shares"
    Access keys are not permitted for Storage Accounts and are enforced by a policy.
    However, they are needed in some scenarios, e.g. for File Shares.
    
    In this case the Storage Account should be created with `shared_access_key_enabled` set to `false`.
    Afterwards a [Policy Exemption](policyexemption.md) should be requested, and when it has 
    been provided, then `shared_access_key_enabled` can be changed to `true`.

``` terraform linenums="1"
--8<-- "templates/storageaccount.tf"
```
