resource "azurerm_linux_virtual_machine" "vm" {
  for_each                = var.vm_instances
  name                    = each.key
  computer_name       = each.key
  resource_group_name     = var.resource_group_name
  location                = var.location
  size                    = each.value
  # count                   = var.nb_count
  admin_username          = var.admin_username
  disable_password_authentication = true
  network_interface_ids   = [azurerm_network_interface.nic[each.key].id]
  availability_set_id     = azurerm_availability_set.linux_availability_set.id
  tags                = local.common_tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  os_disk {
    name                 = "${each.key}-os-disk-${count.index}"
    caching              = var.los_disk_attr["los_disk_caching"]
    storage_account_type = var.los_disk_attr["los_storage_account_type"]
    disk_size_gb         = var.los_disk_attr["los_disk_size"]
  }

  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.linux_version
  }
  
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

}

resource "azurerm_virtual_machine_extension" "networkWatcher" {
    name                 = "networkWatcher"
    publisher            = "Microsoft.Azure.NetworkWatcher"
    type                 = "NetworkWatcherAgentLinux"
    type_handler_version = "1.0"
    virtual_machine_id = azurerm_linux_virtual_machine.vm.virtual_machine_id
  }

  resource "azurerm_virtual_machine_extension" "azureMonitor" {
    name                 = "azureMonitor"
    publisher            = "Microsoft.Azure.Monitor"
    type                 = "AzureMonitorLinuxAgent"
    type_handler_version = "1.0"
    virtual_machine_id = azurerm_linux_virtual_machine.vm.virtual_machine_id
  }

resource "azurerm_public_ip" "vm_public_ip" {
  for_each                = var.vm_instances
  name                    = "${each.key}-publicip-${count.index}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  for_each                = var.vm_instances
  name                    = "${each.key}-nic-${count.index}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  
  ip_configuration {
    name                          = "${each.key}-ipconfig-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip[each.key].id
  }
}

resource "azurerm_availability_set" "linux_availability_set" {
  name                         = var.linux_availability_set
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
}

