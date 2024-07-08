locals {
  prefix = "s-weu-dev-clouddocs"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = var.base.tags
}

resource "azurerm_app_configuration" "appconf" {
  name                = "${local.prefix}-appcs"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku                   = "standard"
  public_network_access = "Disabled"
  local_auth_enabled    = false

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_private_endpoint" "appconf_pep" {
  name                = "${azurerm_app_configuration.appconf.name}-pep"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.subnet["example-snet"].id

  private_service_connection {
    name                           = "${azurerm_app_configuration.appconf.name}-psc"
    private_connection_resource_id = azurerm_app_configuration.appconf.id
    is_manual_connection           = false
    subresource_names              = ["configurationStores"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}
