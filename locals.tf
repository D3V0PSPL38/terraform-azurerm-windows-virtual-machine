### [BEGIN] locals.tf ###
locals {
  ### [BEGIN] winrm_listener ###
  winrm_listener_object = flatten([for key, winrm in var.azurerm_windows_virtual_machine_object : [
    for index in range(length(winrm.winrm_listener)) : {
      protocol        = winrm.protocol == null ? var.winrm_protocol : winrm.protocol
      certificate_url = winrm.certificate_url == null ? var.winrm_certificate_url : winrm.certificate_url
    }
    ]
  ])

  winrm_protocol = flatten([ for key,proto in local.winrm_listener_object : [
    for index in range(length(keys(proto.winrm_listener_object))) : merge(
      {
        key = key
        protocol = proto.protocol[index]
      }
    )
  ]])
  ### [END] winrm_listener ###
}
### [END] locals.tf ###