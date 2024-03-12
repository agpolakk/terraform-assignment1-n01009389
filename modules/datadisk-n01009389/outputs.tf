output "data_disk_ids" {
  description = "IDs of the provisioned data disks."
  value       = azurerm_managed_disk.datadisk[*].id
}
