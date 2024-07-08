data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.base.tags
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                                  = "${var.base.prefix}cosmos"
  location                              = azurerm_resource_group.main.location
  resource_group_name                   = azurerm_resource_group.main.name
  offer_type                            = "Standard"
  kind                                  = "GlobalDocumentDB"
  local_authentication_disabled         = true
  is_virtual_network_filter_enabled     = false
  minimal_tls_version                   = "Tls12"
  network_acl_bypass_for_azure_services = false
  access_key_metadata_writes_enabled    = false
  public_network_access_enabled         = false

  consistency_policy {
    consistency_level = "BoundedStaleness"
  }

  geo_location {
    location          = "westeurope"
    failover_priority = 0
    zone_redundant    = false
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.base.tags
}

resource "azurerm_cosmosdb_sql_database" "cosmos_sql_db" {
  name                = "${var.base.prefix}cosmos"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  throughput          = 400
}

resource "azurerm_private_endpoint" "cosmosdb_pep" {
  name                = "${var.base.prefix}pep-cosmos"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.subnet["shared-snet"].id

  private_service_connection {
    name                           = "${var.base.prefix}psc"
    private_connection_resource_id = azurerm_cosmosdb_account.cosmosdb.id
    is_manual_connection           = false
    subresource_names              = ["Sql"] // Sql, SqlDedicated, Cassandra, MongoDB, Gremlin, Table
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }

  tags = var.base.tags
}

resource "azurerm_private_endpoint_application_security_group_association" "db" {
  private_endpoint_id           = azurerm_private_endpoint.cosmosdb_pep.id
  application_security_group_id = azurerm_application_security_group.cosmos_asg.id
}


// When using NoSQL api RBAC role assignment should be used.
// Cosmos DB have two built-in roles:
//    Cosmos DB Built-in Data Contributor - id: 00000000-0000-0000-0000-000000000002
//    Cosmos DB Built-in Data Reader      - id: 00000000-0000-0000-0000-000000000001
resource "azurerm_cosmosdb_sql_role_assignment" "cosmos_db_contributor" {
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  role_definition_id  = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002" // Data contributor on cosmos db
  principal_id        = data.azurerm_client_config.current.object_id
  scope               = azurerm_cosmosdb_account.cosmosdb.id
}
