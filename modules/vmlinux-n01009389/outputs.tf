# output "vm_info" {
#   description = "Information about the provisioned virtual machines."
#   value       = azurerm_linux_virtual_machine.vm_info
# }

output "vm_hostname" {
  value = azurerm_linux_virtual_machine.vm[*].computer_name
}
output "vm_fqdn" {
  value = azurerm_public_ip.public_ip[*].fqdn
}
output "private_ip_address" {
  value = azurerm_network_interface.nic[*].private_ip_address
}
output "public_ip_address" {
  value = azurerm_public_ip.vm_public_ip[*].ip_address
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
output "vnet_address_space" {
  value = azurerm_virtual_network.network.address_space
}
output "subnet_name" {
  value = azurerm_subnet.subnet.name
}
output "subnet_address_space" {
  value = azurerm_subnet.subnet.address_prefixes
}

output "linux_availability_set" {
  value = azurerm_availability_set.network[*].name
}
