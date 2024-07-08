resource "azapi_resource" "botservice" {
  type      = "Microsoft.BotService/botServices@2022-09-15"
  name      = "s-weu-dev-clouddocs-bot"
  location  = azurerm_resource_group.main.location
  parent_id = azurerm_resource_group.main.id
  body = jsonencode({
    properties = {
      disableLocalAuth    = true
      displayName         = "s-weu-dev-clouddocs-bot"
      endpoint            = "https://clouddocsbot.com"
      msaAppId            = module.app_registration.app_id
      msaAppTenantId      = var.tenant_id
      msaAppType          = "SingleTenant"
      publicNetworkAccess = "Disabled"
      tenantId            = var.tenant_id
    }
    sku = {
      name = "F0"
    }
    kind = "azurebot"
  })
}

resource "azurerm_private_endpoint" "search" {
  name                = "${azapi_resource.botservice.name}-pep"
  resource_group_name = azurerm_resource_group.main.name
  location            = azapi_resource.botservice.location
  subnet_id           = var.private_endpoint_subnet_id

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }

  private_service_connection {
    name                           = "${azapi_resource.botservice.name}-psc"
    private_connection_resource_id = azapi_resource.botservice.id
    is_manual_connection           = false
    subresource_names              = ["Bot", "Token"]
  }
}