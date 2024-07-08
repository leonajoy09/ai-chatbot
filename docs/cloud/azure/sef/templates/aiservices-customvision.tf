locals {
  customvision_resourcename = "s-weu-dev-clouddocs-cv"
}

resource "azurerm_cognitive_account" "customvision_training" {
  name                = local.customvision_resourcename
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "CustomVision.Training"

  sku_name                      = "S0"
  local_auth_enabled            = false
  public_network_access_enabled = false
  custom_subdomain_name         = local.customvision_resourcename
}

resource "azurerm_private_endpoint" "customvision_training" {
  name                = "${azurerm_cognitive_account.customvision_training.name}-pep"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_cognitive_account.customvision_training.location
  subnet_id           = azurerm_subnet.subnet["example-snet"].id

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }

  private_service_connection {
    name                           = "${azurerm_cognitive_account.customvision_training.name}-psc"
    private_connection_resource_id = azurerm_cognitive_account.customvision_training.id
    is_manual_connection           = false
    subresource_names              = ["account"]
  }
}
