resource "azurerm_service_plan" "linux" {
  name                = "${local.prefix}asp"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                          = "${local.prefix}app"
  resource_group_name           = var.resource_group.name
  location                      = var.resource_group.location
  service_plan_id               = azurerm_service_plan.linux.id
  public_network_access_enabled = false

  https_only                = true
  client_affinity_enabled   = true
  virtual_network_subnet_id = data.azurerm_subnet.snet["app"].id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on              = true
    vnet_route_all_enabled = true
    minimum_tls_version    = "1.2"
    http2_enabled          = true
    ftps_state             = "Disabled"

    application_stack {
      dotnet_version = "7.0"
    }
  }
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${local.prefix}-pep"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  subnet_id           = data.azurerm_subnet.snet["default"].id

  private_service_connection {
    name                           = "${local.prefix}-psc"
    private_connection_resource_id = azurerm_linux_web_app.webapp.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}