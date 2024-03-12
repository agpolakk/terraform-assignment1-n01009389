
output "rgroup_name" {
  value = module.rgroup.rgroup_name
}

output "network_info" {
  value = {
    vnet_name   = module.network.vnet_name
    subnet_name = module.network.subnet_name
  }
}

// Similarly, define outputs for other modules
