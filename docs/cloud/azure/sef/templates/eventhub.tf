locals {
  prefix     = "s-weu-dev-clouddocs"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_eventhub_namespace" "evhns" {
  name                = "${local.prefix}-evhns"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"
  capacity            = 1

  minimum_tls_version           = "1.2"
  public_network_access_enabled = false
  local_authentication_enabled  = false

  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${azurerm_eventhub_namespace.evhns.name}-pep"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_eventhub_namespace.evhns.name}-psc"
    private_connection_resource_id = azurerm_eventhub_namespace.evhns.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}


resource "azurerm_eventhub" "evh" {
  name                = "${local.prefix}-evh"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = azurerm_resource_group.main.name
  partition_count     = 2
  message_retention   = 1

  tags = var.tags
}