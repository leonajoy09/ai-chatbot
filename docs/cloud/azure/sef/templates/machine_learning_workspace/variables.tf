variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "prefix" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "application_insights_id" {
  type = string
}

variable "compute_instances" {
  type = list(object({
    name                    = string
    description             = optional(string, "")
    vm_size                 = string
    assigned_user_object_id = string
    managed_identity_id     = optional(string)
  }))
  default = []
}

variable "compute_clusters" {
  type = list(object({
    name                = string
    description         = optional(string, "")
    vm_priority         = string
    vm_size             = string
    managed_identity_id = optional(string)
    scale_settings = object({
      min_node_count                       = number
      max_node_count                       = number
      scale_down_nodes_after_idle_duration = string
    })
  }))
}

variable "online_endpoints" {
  type = list(object({
    name        = string
    description = optional(string, "")
  }))
  default = []
}

variable "batch_endpoints" {
  type = list(object({
    name        = string
    description = optional(string, "")
  }))
  default = []
}

