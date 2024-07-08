terraform {
  required_version = "<= 2.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 4.0.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
}

locals {
  image_build_compute_name = "${var.prefix}-imgbuild"
}

resource "azurerm_key_vault" "keyvault" {
  name                = "${var.prefix}kv"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id

  sku_name                      = "standard"
  public_network_access_enabled = false
  soft_delete_retention_days    = 30
  purge_protection_enabled      = true
  enable_rbac_authorization     = true

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}

resource "azurerm_private_endpoint" "keyvault" {
  name                = "${azurerm_key_vault.keyvault.name}-pep"
  resource_group_name = azurerm_key_vault.keyvault.resource_group_name
  location            = azurerm_key_vault.keyvault.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_key_vault.keyvault.name}-psc"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_storage_account" "sa" {
  name                            = "${replace(var.prefix, "-", "")}sa"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = true
  default_to_oauth_authentication = false

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
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_storage_account.sa.name}-blob-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
  }
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_private_endpoint" "sa_file" {
  name                = "${azurerm_storage_account.sa.name}-file-pep"
  resource_group_name = azurerm_storage_account.sa.resource_group_name
  location            = azurerm_storage_account.sa.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_storage_account.sa.name}-file-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["file"]
  }
  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

# Container Registry

resource "azurerm_container_registry" "acr" {
  name                          = "${replace(var.prefix, "-", "")}acr"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Premium"
  public_network_access_enabled = false
  anonymous_pull_enabled        = false
  admin_enabled                 = false

  identity {
    type = "SystemAssigned"
  }

  retention_policy = [{
    days    = 7
    enabled = true
  }]
}

resource "azurerm_private_endpoint" "acr" {
  name                = "${azurerm_container_registry.acr.name}-pep"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_container_registry.acr.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

# Role assignments as specified by the Microsoft documentation:
# https://learn.microsoft.com/en-us/azure/machine-learning/how-to-identity-based-service-authentication?view=azureml-api-2&tabs=cli#user-assigned-managed-identity

resource "azurerm_user_assigned_identity" "identity" {
  name                = "${var.prefix}mlw-id"
  location            = var.location
  resource_group_name = var.resource_group_name
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
  scope                = var.application_insights_id
  role_definition_name = "App Developer"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_role_assignment" "acr_contributor" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "App Developer"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}


resource "azurerm_machine_learning_workspace" "mlw" {
  name                          = "${var.prefix}mlw"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  application_insights_id       = var.application_insights_id
  key_vault_id                  = azurerm_key_vault.keyvault.id
  storage_account_id            = azurerm_storage_account.sa.id
  container_registry_id         = azurerm_container_registry.acr.id
  image_build_compute_name      = local.image_build_compute_name
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
    azurerm_role_assignment.acr_contributor,
  ]
}

resource "azurerm_private_endpoint" "mlw" {
  name                = "${azurerm_machine_learning_workspace.mlw.name}-pep"
  resource_group_name = azurerm_machine_learning_workspace.mlw.resource_group_name
  location            = azurerm_machine_learning_workspace.mlw.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_machine_learning_workspace.mlw.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_machine_learning_workspace.mlw.id
    subresource_names              = ["amlworkspace"]
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_machine_learning_compute_cluster" "default_build_cluster" {
  name                          = local.image_build_compute_name
  location                      = var.location
  vm_priority                   = "LowPriority"
  vm_size                       = "Standard_DS2_v2"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mlw.id
  subnet_resource_id            = var.subnet_id
  node_public_ip_enabled        = false
  local_auth_enabled            = false
  scale_settings {
    min_node_count                       = 0
    max_node_count                       = 1
    scale_down_nodes_after_idle_duration = "PT30S" # 30 seconds
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_private_endpoint.mlw]
}

# Compute 

resource "azurerm_machine_learning_compute_instance" "compute_instance" {
  for_each = {
    for instance in var.compute_instances : instance.name => instance
  }
  name                          = each.key
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mlw.id
  virtual_machine_size          = each.value.vm_size #"STANDARD_DS2_V2"
  subnet_resource_id            = var.subnet_id

  node_public_ip_enabled = false
  local_auth_enabled     = false

  dynamic "identity" {
    for_each = each.value.managed_identity_id != null ? { id = each.value.managed_identity_id } : {}
    content {
      type         = "UserAssigned"
      identity_ids = [identity.value.id]
    }
  }

  assign_to_user {
    object_id = each.value.assigned_user_object_id
    tenant_id = var.tenant_id
  }

  depends_on = [azurerm_private_endpoint.mlw]
}

resource "azurerm_machine_learning_compute_cluster" "cluster" {
  for_each = {
    for cluster in var.compute_clusters : cluster.name => cluster
  }
  name                          = each.key
  location                      = var.location
  vm_priority                   = each.value.vm_priority
  vm_size                       = each.value.vm_size
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mlw.id
  subnet_resource_id            = var.subnet_id
  node_public_ip_enabled        = false
  local_auth_enabled            = false

  scale_settings {
    min_node_count                       = each.value.scale_settings.min_node_count
    max_node_count                       = each.value.scale_settings.max_node_count
    scale_down_nodes_after_idle_duration = each.value.scale_settings.scale_down_nodes_after_idle_duration # "PT30S" # 30 seconds
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_private_endpoint.mlw]
}

# Endpoints
resource "azapi_resource" "online_endpoint" {
  for_each = {
    for endpoint in var.online_endpoints : endpoint.name => endpoint
  }

  type      = "Microsoft.MachineLearningServices/workspaces/onlineEndpoints@2024-04-01-preview"
  parent_id = azurerm_machine_learning_workspace.mlw.id
  name      = "${var.prefix}${each.key}"
  body = jsonencode({
    location = var.location
    properties = {
      authMode            = "AMLToken"
      description         = each.value.description
      publicNetworkAccess = "Disabled"
    }
  })
  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_private_endpoint.mlw]
}

resource "azapi_resource" "batch_endpoint" {
  for_each = {
    for endpoint in var.batch_endpoints : endpoint.name => endpoint
  }

  type      = "Microsoft.MachineLearningServices/workspaces/batchEndpoints@2024-04-01-preview"
  parent_id = azurerm_machine_learning_workspace.mlw.id
  name      = "${var.prefix}${each.key}"
  body = jsonencode({
    location = var.location
    properties = {
      authMode    = "AADToken"
      description = each.value.description
    }
  })
  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_private_endpoint.mlw]
}
