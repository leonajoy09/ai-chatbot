locals {
  prefix = "s-weu-dev-clouddocs"
  prefix_alphanumeric = replace(local.prefix, "-", "")
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = var.base.tags
}

resource "azurerm_container_registry" "acr" {
  name                          = "${local.prefix_alphanumeric}acr"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  sku                           = "Premium"
  public_network_access_enabled = false
  anonymous_pull_enabled        = false
  admin_enabled                 = false
  tags                          = var.base.tags

  identity {
    type = "SystemAssigned"
  }

  retention_policy = [{
    days    = 7
    enabled = true
  }]
}

resource "azurerm_private_endpoint" "acr" {
  name                = "${azurerm_container_registry.acr.name}-pep"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.subnet["example-snet"].id
  tags                = var.base.tags

  private_service_connection {
    name                           = "${azurerm_container_registry.acr.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}
