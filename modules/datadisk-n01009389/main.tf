resource "azurerm_managed_disk" "datadisk" {
  # count                   = var.disk_count
  for_each                = var.disk_name
  # name                    = "${var.disk_name}-${count.index}"
  name                    = each.key
  location                = var.location
  resource_group_name     = var.resource_group_name
  storage_account_type    = var.storage_account_type
  create_option           = "Empty"
  # disk_size_gb            = var.disk_size_gb
  disk_size_gb            = each.value
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  count             = var.disk_count
  virtual_machine_id = var.virtual_machine_id[count.index]
  caching       = var.caching
  managed_disk_id   = azurerm_managed_disk.datadisk[count.index].id
  lun               = count.index
}

# output "data_disk_ids" {
#   value = azurerm_managed_disk.datadisk[*].id
# }
