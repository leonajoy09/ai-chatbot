resource "azurerm_mssql_server" "sqlserver" {
  name                          = "s-weu-dev-clouddocs-sql"
  resource_group_name           = var.resource_group.name
  location                      = var.resource_group.location
  version                       = "12.0"
  administrator_login           = "mssqladmin"
  administrator_login_password  = "" // Referenced ideally from a Key Vault
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false

  azuread_administrator {
    // Reference to a Azure AD object, i.e. an AAD group
    login_username = "AzureAD Admin"
    object_id      = "00000000-0000-0000-0000-000000000000"
  }
}

resource "azurerm_mssql_database" "db" {
  name      = "${azurerm_mssql_server.sqlserver.name}-sqldb"
  server_id = azurerm_mssql_server.sqlserver.id
  sku_name  = var.database_sku
}

resource "azurerm_private_endpoint" "sqlserver" {
  name                = "${azurerm_mssql_server.sqlserver.name}-pep"
  resource_group_name = azurerm_mssql_server.sqlserver.resource_group_name
  location            = azurerm_mssql_server.sqlserver.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${azurerm_mssql_server.sqlserver.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.sqlserver.id
    subresource_names              = ["sqlServer"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}