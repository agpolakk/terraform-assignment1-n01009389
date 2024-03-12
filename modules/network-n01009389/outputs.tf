output "vnet_name" {
  description = "Name of the provisioned virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  description = "Name of the provisioned subnet."
  value       = azurerm_subnet.subnet.name
}

output "nsg_name" {
  description = "Name of the provisioned virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_address" {
  description = "Name of the provisioned subnet."
  value       = azurerm_subnet.address_prefixes
}
