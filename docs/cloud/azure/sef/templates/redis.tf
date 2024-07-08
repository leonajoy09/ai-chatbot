locals {
  prefix     = "s-weu-dev-clouddocs"
  short_name = replace(local.prefix, "-", "")
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.base.tags
}

resource "azurerm_storage_account" "sa" {
  name                            = "${local.short_name}sa"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = false
  shared_access_key_enabled       = false

  network_rules {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  tags = var.base.tags
}

module "sa_blob_pep" {
  source = "../../modules/private_endpoint"

  prefix         = azurerm_storage_account.sa.name
  subnet_id      = azurerm_subnet.subnet["example-snet"].id
  subresources   = ["blob"]
  resource_group = azurerm_resource_group.main
  resource_id    = azurerm_storage_account.sa.id
  tags           = var.base.tags
  asgs           = [azurerm_application_security_group.sa_asg.id]

  depends_on = [
    azurerm_application_security_group.sa_asg
  ]
}

# Using azpi_resource as "preferred-data-persistence-auth-method" within redisConfiguration is not supported in azurerm yet.
resource "azapi_resource" "redis" {
  type      = "Microsoft.Cache/redis@2023-08-01"
  name      = "${local.prefix}redis"
  location  = azurerm_resource_group.main.location
  parent_id = azurerm_resource_group.main.id
  tags      = var.base.tags
  identity {
    type = "SystemAssigned"
  }
  body = jsonencode({
    properties = {
      enableNonSslPort    = false
      minimumTlsVersion   = "1.2"
      publicNetworkAccess = "Disabled"
      redisConfiguration = {
        aad-enabled                            = "true"
        authnotrequired                        = "no"
        preferred-data-persistence-auth-method = "managedIdentity"
        rdb-backup-enabled                     = "true"
        rdb-backup-frequency                   = "15"
        rdb-backup-max-snapshot-count          = "1"
        rdb-storage-connection-string          = azurerm_storage_account.sa.primary_blob_connection_string
      }
      redisVersion = "6.0"
      sku = {
        capacity = 2
        family   = "P"
        name     = "Premium"
      }
      subnetId = azurerm_subnet.subnet["example-snet"].id
    }
  })
}

resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azapi_resource.redis.identity[0].principal_id
}
