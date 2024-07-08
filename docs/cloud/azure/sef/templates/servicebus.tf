locals {
  prefix     = "s-weu-dev-clouddocs"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_servicebus_namespace" "servicebus" {
  name                          = "${local.prefix}-sbns"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  sku                           = "Premium"
  public_network_access_enabled = false
  capacity                      = 1
  local_auth_enabled            = false
  minimum_tls_version           = "1.2"
  premium_messaging_partitions  = 1
  
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_servicebus_topic" "test" {
  name                = "test"
  namespace_id        = azurerm_servicebus_namespace.servicebus.id
  enable_partitioning = false
}

resource "azurerm_servicebus_queue" "test" {
  name         = "test"
  namespace_id = azurerm_servicebus_namespace.servicebus.id
}

resource "azurerm_private_endpoint" "appconf_pep" {
  name                = "${azurerm_servicebus_namespace.servicebus.name}-pep"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.subnet["example-snet"].id

  private_service_connection {
    name                           = "${azurerm_servicebus_namespace.servicebus.name}-psc"
    private_connection_resource_id = azurerm_servicebus_namespace.servicebus.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}
