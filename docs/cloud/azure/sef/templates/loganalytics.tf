resource "azurerm_log_analytics_workspace" "workspace" {
  name                          = "${var.prefix}log"
  resource_group_name           = var.resource_group.name
  location                      = var.resource_group.location
  sku                           = "PerGB2018"
  local_authentication_disabled = false
  retention_in_days             = 30

  tags = var.tags
}
