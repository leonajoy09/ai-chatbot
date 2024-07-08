locals {
  prefix     = replace(var.base.prefix, "_", "-")
  allowedIps = ["10.1.3.4"]
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.base.tags
}

resource "azurerm_cdn_frontdoor_profile" "example" {
  name                = "${local.prefix}adf"
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "Premium_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "example" {
  name                     = "${local.prefix}endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
  enabled                  = true
}

resource "azurerm_cdn_frontdoor_firewall_policy" "example" {
  name                              = "${local.prefix}wafpolicy"
  resource_group_name               = azurerm_resource_group.main.name
  sku_name                          = azurerm_cdn_frontdoor_profile.example.sku_name
  enabled                           = true
  mode                              = "Prevention"
  redirect_url                      = "https://www.contoso.com"
  custom_block_response_status_code = 403
  custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"

    exclusion {
      match_variable = "QueryStringArgNames"
      operator       = "Equals"
      selector       = "not_suspicious"
    }

    override {
      rule_group_name = "PHP"

      rule {
        rule_id = "933100"
        enabled = false
        action  = "Block"
      }
    }

    override {
      rule_group_name = "SQLI"

      exclusion {
        match_variable = "QueryStringArgNames"
        operator       = "Equals"
        selector       = "really_not_suspicious"
      }

      rule {
        rule_id = "942200"
        action  = "Block"

        exclusion {
          match_variable = "QueryStringArgNames"
          operator       = "Equals"
          selector       = "innocent"
        }
      }
    }
    action = "Log"
  }

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
    action  = "Log"
  }

  custom_rule {
    name                           = "AllowSpecificIps"
    enabled                        = true
    priority                       = 1
    rate_limit_duration_in_minutes = 1
    rate_limit_threshold           = 10
    type                           = "MatchRule"
    action                         = "Allow"

    match_condition {
      match_variable     = "RemoteAddr"
      operator           = "IPMatch"
      negation_condition = false
      match_values       = local.allowedIps
    }
  }

  custom_rule {
    name                           = "Rule2"
    enabled                        = true
    priority                       = 2
    rate_limit_duration_in_minutes = 1
    rate_limit_threshold           = 10
    type                           = "MatchRule"
    action                         = "Block"

    match_condition {
      match_variable     = "RemoteAddr"
      operator           = "IPMatch"
      negation_condition = true
      match_values       = local.allowedIps
    }
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "${local.prefix}acc"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Premium"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false

  network_rules {
    default_action = "Deny"
  }

  tags = {
    environment = "Example"
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "example" {
  name                     = "${local.prefix}origingroup"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id

  load_balancing {}
}

resource "azurerm_cdn_frontdoor_origin" "example" {
  name                           = "${local.prefix}origin"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.example.id
  enabled                        = true
  certificate_name_check_enabled = true

  host_name          = "contoso.com"
  origin_host_header = "www.contoso.com"
  priority           = 1
  weight             = 1

  private_link {
    request_message        = "Request access for Private Link Origin CDN Frontdoor"
    target_type            = "blob"
    location               = azurerm_storage_account.example.location
    private_link_target_id = azurerm_storage_account.example.id
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "example" {
  name                     = "${local.prefix}-Security-Policy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.example.id

      association {
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.example.id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}