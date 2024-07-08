locals {
  base_prefix = "s-weu-dev-clouddocs"
}

resource "azurerm_storage_account" "st" {
  name                            = "${replace(local.base_prefix, "-", "")}st"
  resource_group_name             = var.resource_group.name
  location                        = var.resource_group.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true

  network_rules {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "docs"
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "private"
}

// A file share requires access keys to be enabled. Please read the note above.
resource "azurerm_storage_share" "fileshare" {
  name                 = "share"
  storage_account_name = azurerm_storage_account.st.name
  quota                = 50
}

resource "azurerm_private_endpoint" "st_blob" {
  name                = "${local.base_prefix}-pep-blob"
  resource_group_name = azurerm_storage_account.st.resource_group_name
  location            = azurerm_storage_account.st.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${local.base_prefix}-psc-blob"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.st.id
    subresource_names              = ["blob"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_private_endpoint" "st_share" {
  name                = "${local.base_prefix}-pep-share"
  resource_group_name = azurerm_storage_account.st.resource_group_name
  location            = azurerm_storage_account.st.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${local.base_prefix}-psc-share"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.st.id
    subresource_names              = ["file"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}