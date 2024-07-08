resource "azapi_resource" "backupvault" {
  type = "Microsoft.DataProtection/backupVaults@2022-11-01-preview"
  name = "s-weu-dev-clouddocs-bvault"
  location = var.resource_group.location
  identity {
    type = "SystemAssigned"
  }
  body = jsonencode({
    properties = {
      monitoringSettings = {
        azureMonitorAlertSettings = {
          alertsForAllJobFailures = "Enabled"
        }
      }
      securitySettings = {
        immutabilitySettings = {
          state = "Locked"
        }
        softDeleteSettings = {
          retentionDurationInDays = 14
          state = "ON"
        }
      }
      storageSettings = [
        {
          datastoreType = "Vault"
          type = "LocallyRedundant"
        }
      ]
    }
  })
}