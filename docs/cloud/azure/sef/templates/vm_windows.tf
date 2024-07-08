locals {
  vm_name  = "sweudclddocsvm"
  username = "vmadmin"
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                       = local.vm_name
  resource_group_name        = var.resource_group.name
  location                   = var.resource_group.location
  size                       = "Standard_B2ms"
  admin_username             = local.username
  admin_password             = random_password.admin_password.result
  network_interface_ids      = [azurerm_network_interface.vm.id]
  encryption_at_host_enabled = true
  enable_automatic_updates   = true
  patch_assessment_mode      = "AutomaticByPlatform"
  patch_mode                 = "AutomaticByPlatform"
  provision_vm_agent         = true
  license_type               = "Windows_Server"

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = {
    DomainJoinTo = "azure-lz"
  }

  depends_on = [
    azapi_update_resource.encryptionathost
  ]

  lifecycle {
    ignore_changes = [
      # Ignoring changes to "identity" to avoid removal of identities added as part of Azure Policies.
      # E.g., an identity is added as part of integrating the VM with Crowdstrike. See further down
      # for an example of how to manage additional identities.
      identity
    ]
  }
}

resource "random_password" "admin_password" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_network_interface" "vm" {
  name                = "${local.vm_name}-nic"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azapi_update_resource" "encryptionathost" {
  type        = "Microsoft.Features/featureProviders/subscriptionFeatureRegistrations@2021-07-01"
  resource_id = "/subscriptions/${var.subscription_id}/providers/Microsoft.Features/featureProviders/Microsoft.Compute/subscriptionFeatureRegistrations/encryptionathost"
  body = jsonencode({
    properties = {}
  })
}

# User-Assigned Managed Identities can be attached to the VM using "azapi".

resource "azurerm_user_assigned_identity" "umi1" {
  name                = "umi-1"
  resource_group_name = azurerm_resource_group.vm.name
  location            = azurerm_resource_group.vm.location
}

resource "azurerm_user_assigned_identity" "umi2" {
  name                = "umi-2"
  resource_group_name = azurerm_resource_group.vm.name
  location            = azurerm_resource_group.vm.location
}

locals {
  vm_identities = {
    umi1 = azurerm_user_assigned_identity.umi1.id,
    umi2 = azurerm_user_assigned_identity.umi2.id
  }
}

# Note that separate resources are required for adding and removing to work correctly.

resource "azapi_resource_action" "vm_umi_apply" {
  for_each = local.vm_identities

  type        = "Microsoft.Compute/virtualMachines@2023-09-01"
  resource_id = azurerm_windows_virtual_machine.vm.id
  method      = "PATCH"
  body = jsonencode({
    identity = {
      type = "UserAssigned"
      userAssignedIdentities = {
        "${each.value}" = {}
      }
    }
  })

  when = "apply"
}

resource "azapi_resource_action" "vm_umi_destroy" {
  for_each = local.vm_identities

  type        = "Microsoft.Compute/virtualMachines@2023-09-01"
  resource_id = azurerm_windows_virtual_machine.vm.id
  method      = "PATCH"
  body = jsonencode({
    identity = {
      type = "UserAssigned"
      userAssignedIdentities = {
        "${each.value}" = null
      }
    }
  })

  when = "destroy"
}
