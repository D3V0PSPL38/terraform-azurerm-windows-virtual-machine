### [BEGIN] variables.tf ###
variable "instance_count" {
  description = <<EOD
  [Optional] The number of virtual machines to create.
  EOD
  type        = number
  default     = 1
}

variable "azure_location" {
  description = <<EOD
  [Required] The Azure location where the resource exists.
  EOD
  type        = string
  default     = null
}
### [BEGIN] Object definitions ###
variable "azurerm_windows_virtual_machine_object" {
  description = <<EOD
  [Optional] Configuration Object for azurerm_windows_virtual_machine.
  EOD
  type = map(object({
    admin_password        = optional(string)
    admin_username        = optional(string)
    location              = optional(string)
    name                  = optional(string)
    network_interface_ids = optional(list(string))
    os_disk = optional(object({
      caching              = optional(string)
      storage_account_type = optional(string)
      diff_disk_settings = optional(object({
        option    = optional(string)
        placement = optional(string)
      }))
    }))
    resource_group_name = optional(string)
    size                = optional(string)
    additional_capabilities = optional(object({
      ultra_ssd_enabled = optional(bool)
    }))
    additional_unattend_config = optional(list(object({
      content = optional(string)
      setting = optional(string)
    })))
    allow_extension_operations = optional(bool)
    availability_set_id        = optional(string)
    boot_diagnostics = optional(object({
      storage_uri = optional(string)
    }))
    capacity_reservation_group_id = optional(string)
    computer_name                 = optional(string)
    custom_data                   = optional(string)
    dedicated_host_id             = optional(string)
    dedicated_host_group_id       = optional(string)
    edge_zone                     = optional(string)
    enable_automatic_updates      = optional(bool)
    encryption_at_host_enabled    = optional(bool)
    eviction_policy               = optional(string)
    extensions_time_budget        = optional(string)
    gallery_application = optional(object({
      version_id             = optional(string)
      configuration_blob_uri = optional(string)
      order                  = optional(number)
      tag                    = optional(string)
    }))
    hotpatching_enabled = optional(bool)
    identity = optional(object({
      identity_ids = optional(list(string))
      type         = optional(string)
    }))
    license_type          = optional(string)
    max_bid_price         = optional(string)
    patch_assessment_mode = optional(string)
    patch_mode            = optional(string)
    plan = optional(object({
      name      = optional(string)
      product   = optional(string)
      publisher = optional(string)
    }))
    platform_fault_domain        = optional(number)
    priority                     = optional(string)
    provision_vm_agent           = optional(bool)
    proximity_placement_group_id = optional(string)
    secret = optional(object({
      certificate = optional(object({
        store = optional(string)
        url   = optional(string)
      }))
      key_vault_id = optional(string)
    }))
    secure_boot_enabled = optional(bool)
    source_image_id     = optional(string)
    source_image_reference = optional(object({
      offer     = optional(string)
      publisher = optional(string)
      sku       = optional(string)
      version   = optional(string)
    }))
    termination_notification = optional(object({
      enabled = optional(bool)
      timeout = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
    timezone                     = optional(string)
    user_data                    = optional(string)
    virtual_machine_scale_set_id = optional(string)
    vtpm_enabled                 = optional(bool)
    winrm_listener = optional(list(object({
      certificate_url = optional(string)
      protocol        = optional(string)
    })))
    tags = optional(map(string))
  }))
  default = {}
}
### [END] Object definitions ###
### [BEGIN] variable definitions ###
variable "source_image_reference_version" {
  description = <<EOD
  [Optional] Specifies the version of the image used to create the virtual machine.
  EOD
  type        = string
  default     = null
}

variable "source_image_reference_sku" {
  description = <<EOD
  [Optional] Specifies the SKU of the image used to create the virtual machine.
  EOD
  type        = string
  default     = null
}

variable "source_image_reference_publisher" {
  description = <<EOD
  [Optional] Specifies the publisher of the image used to create the virtual machine.
  EOD
  type        = string
  default     = null
}

variable "source_image_reference_offer" {
  description = <<EOD
  [Optional] Specifies the offer of the image used to create the virtual machine.
  EOD
  type        = string
  default     = null
}

variable "termination_notification_timeout" {
  description = <<EOD
  [Optional] Specifies the timeout of notifications in minutes.
  EOD
  type        = string
  default     = null
}

variable "termination_notification_enabled" {
  description = <<EOD
  [Optional] Specifies whether the Virtual Machine should be marked as Enabled for Termination Notification.
  EOD
  type        = bool
  default     = false
}

variable "winrm_listener_default" {
  description = <<EOD
  [Optional] Default winrm_listener settings.
  EOD
  type        = any
  default = {
    protocol        = "Http"
    certificate_url = null
  }
}

variable "winrm_protocol" {
  description = <<EOD
  [Optional] Specifies the protocol of listener. Possible values are Http or Https.
  EOD
  type        = string
  default     = "Http"
  validation {
    condition     = can(regex("^(Http|Https)$", var.winrm_protocol))
    error_message = "winrm_protocol must be either Http or Https."
  }
}

variable "winrm_certificate_url" {
  description = <<EOD
  [Optional] The Secret URL of a Key Vault Certificate, which must be specified when protocol is set to Https
  EOD
  type        = string
  default     = null
}
### [END] variable definitions ###
### [END] variables.tf ###