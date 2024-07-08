locals {
  prefix = "s-weu-dev-clouddocs"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = var.base.tags
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

// Reference a platform provided Private DNS zone
data "azurerm_private_dns_zone" "mysql" {
  name                = var.private_dns_zone_name
  resource_group_name = var.vnet_resource_group_name
}

resource "azurerm_user_assigned_identity" "mysql" {
  name                = "${local.prefix}-uid"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_mysql_flexible_server" "server" {
  name                   = "${local.prefix}-mysql"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  administrator_login    = "mysqladmin"
  administrator_password = random_password.password.result
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.subnet["example-snet"].id
  private_dns_zone_id    = azurerm_private_dns_zone.mysql.id
  sku_name               = "GP_Standard_D2ds_v4"

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.mysql.id,
    ]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.mysql]
}

resource "azurerm_mysql_flexible_database" "database" {
  name                = "clouddocs"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mysql_flexible_server.server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

data "azurerm_client_config" "current" {
}

resource "azurerm_mysql_flexible_server_active_directory_administrator" "server" {
  server_id   = azurerm_mysql_flexible_server.server.id
  identity_id = azurerm_user_assigned_identity.mysql.id
  login       = "mysqladmin"
  object_id   = var.mysql_aad_owner_object_id
  tenant_id   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_mysql_flexible_server_configuration" "aad_auth_only" {
  name                = "aad_auth_only"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mysql_flexible_server.server.name
  value               = "ON"
}
