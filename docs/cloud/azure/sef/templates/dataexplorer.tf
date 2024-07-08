locals {
  data_explorer_prefix = replace(var.base.prefix, "-", "")
  short_name           = replace(replace(local.data_explorer_prefix, "data_explorer", "dec"), "-", "")
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.base.tags
}

resource "azurerm_kusto_cluster" "kusto_cluster" {
  name                = "${local.short_name}dec"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  public_network_access_enabled = false
  disk_encryption_enabled       = true
  purge_enabled                 = true

  identity {
    type = "SystemAssigned"
  }

  sku {
    name     = "Dev(No SLA)_Standard_D11_v2"
    capacity = 1
  }

  depends_on = [azurerm_subnet_route_table_association.table_association]
}


resource "azurerm_private_endpoint" "kusto_cluster" {
  name                = "${var.base.prefix}pep-dec"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.subnet["pep-snet"].id

  private_service_connection {
    name                           = "${var.base.prefix}psc"
    private_connection_resource_id = azurerm_kusto_cluster.kusto_cluster.id
    is_manual_connection           = false
    subresource_names              = ["cluster"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}