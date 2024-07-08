locals {
  prefix     = "s-weu-dev-clouddocs"
  short_name = replace(local.prefix, "-", "")
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                          = "${var.prefix}-log"
  resource_group_name           = var.resource_group.name
  location                      = var.resource_group.location
  sku                           = "PerGB2018"
  local_authentication_disabled = true
  retention_in_days             = 30
}

resource "azurerm_application_insights" "insight" {
  name                = "${var.prefix}-appi"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  workspace_id                  = azurerm_log_analytics_workspace.workspace.id
  application_type              = "web"
  retention_in_days             = 30
  local_authentication_disabled = true
}

resource "azurerm_key_vault" "keyvault" {
  name                = "${local.prefix}-kv"
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

  private_service_connection {
    name                           = "${azurerm_key_vault.keyvault.name}-psc"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}

resource "azurerm_storage_account" "sa" {
  name                            = "${local.short_name}sa"
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

resource "azurerm_private_endpoint" "sa_blob" {
  name                = "${azurerm_storage_account.sa.name}-blob-pep"
  resource_group_name = azurerm_storage_account.sa.resource_group_name
  location            = azurerm_storage_account.sa.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${azurerm_storage_account.sa.name}-blob-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
  }
}

# Role assignments as specified by the Microsoft documentation:
# https://learn.microsoft.com/en-us/azure/machine-learning/how-to-identity-based-service-authentication?view=azureml-api-2&tabs=cli#user-assigned-managed-identity
resource "azurerm_user_assigned_identity" "identity" {
  name                = "${local.prefix}mlw-id"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_role_assignment" "key_vault_administrator" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}


resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

# The 'App Developer' role is used instead of the 'Contributor' role
# as the latter is disallowed in the new landing zone
resource "azurerm_role_assignment" "key_vault_contributor" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "App Developer"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_role_assignment" "storage_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "App Developer"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_role_assignment" "application_insights_contributor" {
  scope                = azurerm_application_insights.insights.id
  role_definition_name = "App Developer"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_machine_learning_workspace" "mlw" {
  name                    = "${local.prefix}-mlw"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  application_insights_id = azurerm_application_insights.insights.id
  key_vault_id            = azurerm_key_vault.keyvault.id
  storage_account_id      = azurerm_storage_account.sa.id

  high_business_impact          = true
  public_network_access_enabled = false

  primary_user_assigned_identity = azurerm_user_assigned_identity.identity.id

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.identity.id,
    ]
  }

  depends_on = [
    azurerm_role_assignment.storage_blob_data_contributor,
    azurerm_role_assignment.key_vault_administrator,
    azurerm_role_assignment.key_vault_contributor,
    azurerm_role_assignment.storage_contributor,
    azurerm_role_assignment.application_insights_contributor,
  ]
}

resource "azurerm_private_endpoint" "mlw" {
  name                = "${azurerm_machine_learning_workspace.mlw.name}-pep"
  resource_group_name = azurerm_machine_learning_workspace.mlw.resource_group_name
  location            = azurerm_machine_learning_workspace.mlw.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${azurerm_machine_learning_workspace.mlw.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_machine_learning_workspace.mlw.id
    subresource_names              = ["amlworkspace"]
  }
}