// Storage Account for Function App

resource "azurerm_storage_account" "functionapp" {
  name                            = "sweudevclouddocsfuncsa"
  resource_group_name             = var.resource_group.name
  location                        = var.resource_group.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = false
  // Shared Access Key should be enabled since Function Apps are using the Azure Files functionality
  shared_access_key_enabled = true

  network_rules {
    default_action = "Deny"
  }

  tags = var.tags
}

resource "azurerm_storage_share" "functionapp" {
  name                 = "functionapp"
  storage_account_name = azurerm_storage_account.functionapp.name
  quota                = 100
}

resource "azurerm_private_endpoint" "storageaccount_blob" {
  name                = "${var.azurerm_storage_account.functionapp.name}-pep"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.azurerm_storage_account.functionapp.name}-psc"
    private_connection_resource_id = azurerm_storage_account.functionapp.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_private_endpoint" "storageaccount_file" {
  name                = "${var.azurerm_storage_account.functionapp.name}-pep"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  subnet_id           = var.privateendpoint_subnet_id

  private_service_connection {
    name                           = "${var.azurerm_storage_account.functionapp.name}-psc"
    private_connection_resource_id = azurerm_storage_account.functionapp.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

// Function App

resource "azurerm_service_plan" "functionapp" {
  name                = "s-weu-dev-clouddocs-func-asp"
  resource_group_name = azurerm_resource_group.monitor.name
  location            = azurerm_resource_group.monitor.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "functionapp" {
  name                          = "s-weu-dev-clouddocs-func"
  resource_group_name           = var.resource_group.name
  location                      = var.resource_group.location
  service_plan_id               = azurerm_service_plan.functionapp.id
  functions_extension_version   = "~4"
  storage_account_name          = azurerm_storage_account.functionapp.name
  storage_account_access_key    = azurerm_storage_account.functionapp.primary_access_key
  virtual_network_subnet_id     = var.functionapp_subnet_id
  https_only                    = true
  public_network_access_enabled = false
  tags                          = var.tags

  site_config {
    application_insights_connection_string = var.application_insights.connection_string
    application_insights_key               = var.application_insights.instrumentation_key
    vnet_route_all_enabled                 = true
    minimum_tls_version                    = "1.2"
    http2_enabled                          = true
    always_on                              = true

    // Application Stack varies depending on the function application code
    application_stack {
      dotnet_version              = "6"
      use_dotnet_isolated_runtime = true
    }
  }

  app_settings = {
    "WEBSITE_CONTENTSHARE"    = azurerm_storage_share.functionapp.name
    "WEBSITE_CONTENTOVERVNET" = "1"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_private_endpoint" "functionapp" {
  name                = "${azurerm_linux_function_app.functionapp.name}-pep"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  subnet_id           = var.privateendpoint_subnet_id

  private_service_connection {
    name                           = "${azurerm_linux_function_app.functionapp.name}-psc"
    private_connection_resource_id = azurerm_linux_function_app.functionapp.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "functionapp" {
  name                       = "${azurerm_linux_function_app.functionapp.name}-diag"
  target_resource_id         = azurerm_linux_function_app.functionapp.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "FunctionAppLogs"
    retention_policy {
      enabled = false
    }
  }
}
