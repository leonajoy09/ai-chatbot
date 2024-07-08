data "azurerm_client_config" "current" {}

data "azuread_user" "current_user" {
  object_id = data.azurerm_client_config.current.object_id
}

resource "azurerm_postgresql_flexible_server" "server" {
  name                = "s-weu-dev-clouddocs-psql"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  version             = "15"
  storage_mb          = 32768
  sku_name            = "B_Standard_B1ms"
  zone                = 1
  delegated_subnet_id = var.subnet_id // Reference to Landing Zone subnet
  private_dns_zone_id = var.private_dns_zone_id // Reference to Landing Zone provisioned Private DNS zone

  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = false
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }
}

resource "azurerm_postgresql_flexible_server_database" "database" {
  name      = "test-db"
  server_id = azurerm_postgresql_flexible_server.server.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "main" {
  server_name         = azurerm_postgresql_flexible_server.server.name
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  principal_name      = data.azuread_user.current_user.user_principal_name
  principal_type      = "User"
}