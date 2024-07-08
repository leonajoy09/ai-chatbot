resource "azurerm_key_vault" "keyvault" {
  name                = "s-weu-dev-clouddocs-kv"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                      = "standard"
  public_network_access_enabled = false
  soft_delete_retention_days    = 30
  purge_protection_enabled      = true
  enable_rbac_authorization     = true

  network_acls {
    default_action = "Deny"
    bypass         = "None"
  }
}

resource "azurerm_private_endpoint" "keyvault" {
  name                = "${azurerm_key_vault.keyvault.name}-pep"
  resource_group_name = azurerm_key_vault.keyvault.resource_group_name
  location            = azurerm_key_vault.keyvault.location
  subnet_id           = var.private_endpoint_subnet_id

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }

  private_service_connection {
    name                           = "${azurerm_key_vault.keyvault.name}-psc"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}