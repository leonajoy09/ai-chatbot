resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.base.tags
}


resource "azurerm_load_test" "load_test" {
  location            = azurerm_resource_group.main.location
  name                = "${var.base.prefix}lt"
  resource_group_name = azurerm_resource_group.main.name

  identity {
    type = "SystemAssigned"
  }
}