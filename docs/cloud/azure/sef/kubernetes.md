# Azure Kubernetes Service (AKS)

```
Microsoft.ContainerService/managedClusters
```

## Minimum required configuration

!!! success "Use the Azure Key Vault provider for Secrets Store CSI Driver"

    Azure Key Vault is a secure and encrypted vault for storing secrets such as passwords, certificates, API keys, and other sensitive information. Secrets used with Azure Kubernetes Services should be managed using the [Azure Key Vault provider for Secrets Store CSI Driver](https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver). Key Vaults enforce secure authentication through Entra ID, secret rotation without application redeployment and support monitoring of access and use.

- Kubernetes node pool and `kube-apiserver` should be integrated into virtual network
- Kubernetes node pool and `kube-apiserver` should have public access disabled
- AKS Backup extension should be installed and a backup strategy for persistent volumes should be set up
- Diagnostic setting with kube-audit category log should be present
- Microsoft Defender for Cloud profile should be enabled
- Azure RBAC integration should be enabled
- Local authentication through Kubernetes RBAC should be disabled
- AKS Policy extension should be installed
- Kubernetes clusters should only be accessible over HTTPS
- Auto-upgrade should be enabled for the Kubernetes version
- Temp disks and cache for nodes should be encrypted using the `EncryptionAtHost` feature
- `CNI` should be used as the networking solution.
- Workload Identities should be used when pods need to authenticate to other Azure Services

## Enforced Policies

{{ display_azure_policies('aks') }}

## Terraform example

Coming soon
