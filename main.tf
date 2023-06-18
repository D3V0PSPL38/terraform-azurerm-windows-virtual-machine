### [BEGIN] main.tf ###
module "label" {
  source          = "github.com/D3V0PSPL38/terraform-context-label.git"
  enabled         = module.this.enabled
  name            = var.name
  namespace       = var.namespace
  environment     = var.environment
  stage           = var.stage
  location        = var.azure_location
  label_order     = var.label_order
  id_length_limit = var.id_length_limit
  tags            = local.tags
  context         = module.this.context
}

resource "azurerm_windows_virtual_machine" "this" {
  # checkov:skip=BC_AZR_GENERAL_89: Encryption is handled via variable definition
  # checkov:skip=BC_AZR_GENERAL_14: Extension enablement is handled via variable definition
  count = local.e ? var.instance_count : 0
  depends_on = [var.azure_vm_depends_on]
  name = format("%s-%02d", module.label.id, count.index + 1)
  admin_password = var.admin_password
  admin_username = var.admin_username
  location = var.azure_location
  network_interface_ids = var.network_interface_ids
  dynamic "os_disk" {
    for_each = var.azurerm_managed_disk_object
    iterator = disk
    content {
      caching = disk.value.caching
      storage_account_type = disk.value.storage_account_type
      dynamic "diff_disk_settings" {
        for_each = var.enable_diff_disk_settings == true ? var.diff_disk_setting : []
        iterataror = diff
        content {
          option = diff.value.option
          placement = diff.value.placement
        }
      }
      resource_group_name = var.resource_group_name
      size = var.os_disk_size
      dynamic "additional_capabilities" {
        for_each = var.enable_additional_capabilities == true ? var.additional_capabilities : []
        iterator = capability
        content {
          ultra_ssd_enabled = capability.value.ultra_ssd_enabled
        }
      }
      dynamic "additional_unattend_config" {
        for_each = var.enable_additional_unattend_config == true ? var.additional_unattend_config : []
        iterator = unattend
        content {
          content = unattend.value.content
          setting = unattend.value.setting
        }
      }
      allow_extension_operations = var.allow_extension_operations
      availability_set_id = var.availability_set_id
      dynamic "boot_diagnostics" {
        for_each = var.enable_boot_diagnostics == true ? var.boot_diagnostics : []
        iterator = diag
        content {
          storage_uri = diag.value.storage_uri
        }
      }
      capacity_reservation_group_id = var.capacity_reservation_group_id
      computer_name = format("%s-%02d", var.computer_name, count.index + 1)
      custom_data = var.custom_data
      dedicated_host_id = var.dedicated_host_id
      dedicated_host_group_id = var.dedicated_host_group_id
      edge_zone = var.edge_zone
      enable_automatic_updates = var.enable_automatic_updates
      encryption_at_host_enabled = var.encryption_at_host_enabled
      eviction_policy = var.eviction_policy
      extensions_time_budget = var.extensions_time_budget
      dynamic "gallery_application" {
        for_each = var.enable_gallery_application == true ? var.gallery_application : []
        iterator = app
        content {
          version_id = app.value.version_id
          configuration_blob_uri = app.value.configuration_blob_uri
          order = app.value.order
          tag = app.value.tag
        }
      }
      hotpatching_enabled = var.hotpatching_enabled
      dynamic "identity" {
        for_each = var.enable_identity == true ? var.identity : []
        iterator = id
        content {
          identity_ids = id.value.identity_ids
          type = id.value.type
        }
      }
      license_type = var.license_type
      max_bid_price = var.max_bid_price
      patch_assessment_mode = var.patch_assessment_mode
      patch_mode = var.patch_mode
      dynamic "plan" {
        for_each = var.enable_plan == true ? var.plan : []
        iterator = plan
        content {
          name = plan.value.name
          product = plan.value.product
          promotion_code = plan.value.promotion_code
          publisher = plan.value.publisher
        }
      }
      platform_fault_domain = var.platform_fault_domain
      priorty = var.priority
      proximity_placement_group_id = var.proximity_placement_group_id
      dynamic "secret" {
        for_each = var.enable_secret == true ? var.secret : []
        iterator = secret
        content {
          dynamic "certificate" {
            for_each = var.enable_certificate == true ? var.certificate : []
            iterator = cert
            content {
              store = cert.value.store
              url = cert.value.url
            }
          }
          vault_id = secret.value.vault_id
        }
      }
      secure_boot_enabled = var.secure_boot_enabled
      source_image_id = var.source_image_id
      dynamic "source_image_reference" {
        for_each = var.enable_source_image_reference == true ? var.source_image_reference : []
        iterator = ref_image
        content {
          id = ref_image.value.id
          publisher = ref_image.value.publisher
          offer = ref_image.value.offer
          sku = ref_image.value.sku
          version = ref_image.value.version
        }
      }
      dynamic "termination_notification" {
        for_each = var.enable_termination_notification == true ? var.termination_notification : []
        iterator = term
        content {
          enabled = term.value.enabled
          time = term.value.time
        }
      }
      dynamic "timeouts" {
        for_each = var.enable_timeouts == true ? var.timeouts : []
        iterator = timeout
        content {
          create = timeout.value.create
          delete = timeout.value.delete
          read = timeout.value.read
          update = timeout.value.update
        }
      }
      timezone = var.timezone
      user_data = var.user_data
      virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
      vtpm_enabled = var.vtpm_enabled
      dynamic "winrm_listener" {
        for_each = var.enable_winrm_listener == true ? var.winrm_listener : []
        iterator = winrm
        content {
          certificate_url = winrm.value.certificate_url
          protocol = winrm.value.protocol
        }
      }
      tags = module.label.tags
    }
  }

}
### [END] main.tf ###
