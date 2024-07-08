resource "azurerm_application_insights" "insight" {
  name                = "${var.prefix}appi"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  workspace_id                  = var.log_analytics_workspace_id
  application_type              = "web"
  retention_in_days             = 30
  local_authentication_disabled = true

  tags = var.tags
}
