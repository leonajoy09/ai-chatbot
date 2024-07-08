resource "azurerm_search_service" "search" {
  name                          = "s-weu-dev-clouddocs-srch"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  sku                           = "standard"  
  local_authentication_enabled  = false
  public_network_access_enabled = false
}

resource "azurerm_storage_account" "st" {
  name                     = "sweudevclouddocsst"
  resource_group_name      = azurerm_search_service.search.resource_group_name
  location                 = azurerm_search_service.search.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_search_shared_private_link_service" "st_link" {
  name               = "s-weu-dev-clouddocs-spl-stblob"
  search_service_id  = azurerm_search_service.search.id
  subresource_name   = "blob"
  target_resource_id = azurerm_storage_account.st.id
  request_message    = "Please grant access for Search to look at storage account data"
}

resource "azurerm_private_endpoint" "search" {
  name                = "${azurerm_search_service.search.name}-pep"
  resource_group_name = azurerm_search_service.search.resource_group_name
  location            = azurerm_search_service.search.location
  subnet_id           = var.private_endpoint_subnet_id

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }

  private_service_connection {
    name                           = "${azurerm_search_service.search.name}-psc"
    private_connection_resource_id = azurerm_search_service.search.id
    is_manual_connection           = false
    subresource_names              = ["searchService"]
  }
}