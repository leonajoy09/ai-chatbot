locals {
  frontend_ip_configuration_public  = "${local.prefix_alphanumeric}-feip-public"
  frontend_ip_configuration_private = "${local.prefix_alphanumeric}-feip-private"
  https_frontend_port               = "${local.prefix_alphanumeric}-https-feport"
  https_listener_suffix             = "httpslstn"
  backend_address_pool_suffix       = "mytma-beap"
  backend_http_settings_suffix      = "be-htst"
  request_routing_rule_suffix       = "rqrt-https"
}

resource "azurerm_public_ip" "pip" {
  name                = "${local.prefix}pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_user_assigned_identity" "gw_identity" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "${local.prefix}id-agw"
}

resource "azurerm_role_assignment" "agw_kv_secrets_user" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.gw_identity.principal_id
}

resource "azurerm_application_gateway" "appgw" {
  name                = "${local.prefix}agw"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  firewall_policy_id  = azurerm_web_application_firewall_policy.waf_configuration.id

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.gw_identity.id]
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }

  gateway_ip_configuration {
    name      = "${local.prefix_alphanumeric}-gw-ip-config"
    subnet_id = data.azurerm_subnet.snet["appgw"].id
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_public
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  frontend_ip_configuration {
    name                          = local.frontend_ip_configuration_private
    private_ip_address            = var.private_ip
    private_ip_address_allocation = "Static"
    subnet_id                     = data.azurerm_subnet.snet["appgw"].id
  }

  frontend_port {
    name = local.https_frontend_port
    port = 443
  }

  dynamic "http_listener" {
    for_each = var.services
    iterator = service
    content {
      name                           = "${service.key}-${local.https_listener_suffix}"
      frontend_ip_configuration_name = service.value.is_public ? local.frontend_ip_configuration_public : local.frontend_ip_configuration_private
      frontend_port_name             = local.https_frontend_port
      protocol                       = "Https"
      host_name                      = service.value.host_name
      ssl_certificate_name           = service.value.cert_name
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.services
    iterator = service

    content {
      name                = service.value.cert_name
      key_vault_secret_id = data.azurerm_key_vault_secret.certificates[service.key].versionless_id
    }
  }

  backend_address_pool {
    fqdns = [var.backend_pool_fqdn]
    name  = "${local.prefix_alphanumeric}-${local.backend_address_pool_suffix}"
  }

  dynamic "backend_http_settings" {
    for_each = var.services
    iterator = service

    content {
      name                  = "${service.key}-${local.backend_http_settings_suffix}"
      port                  = service.value.backend_port
      protocol              = "Https"
      cookie_based_affinity = "Disabled"
      request_timeout       = 60
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.services
    iterator = service

    content {
      name                       = "${service.key}-${local.request_routing_rule_suffix}"
      priority                   = service.value.routing_priority
      rule_type                  = "Basic"
      http_listener_name         = "${service.key}-${local.https_listener_suffix}"
      backend_http_settings_name = "${service.key}-${local.backend_http_settings_suffix}"
      backend_address_pool_name  = "${local.prefix_alphanumeric}-${local.backend_address_pool_suffix}"
    }
  }
}
