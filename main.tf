module "rgroup" {
  source = "./modules/rgroup-n01009389"

  resource_group_name = "n01009389-RG"
  location = "Canada Central"
}

module "network" {
  source = "./modules/network-n01009389"

  resource_group_name     = module.rgroup.rgroup_name.name
  location                = module.rgroup.rgroup_name.location
  vnet_name               = "n01009389-VNET"
  vnet_address_space      = ["10.0.0.0/16"]
  subnet_name             = "n01009389-SUBNET"
  subnet_address_prefixes = ["10.0.0.0/24"]
  nsg_name                = "n01009389-NSG"
}

module "common" {
  source = "./modules/common-n01009389"
  
  resource_group_name     = module.rgroup.rgroup_name.name
  location                = module.rgroup.rgroup_name.location
  recovery_services_vault_name  = "tffiles"
  log_analytics_name  = "assignment-law"
  log_analytics_sku   = "PerGB2018"
  storage_account_name = "assignmentn01009389sa"
  storage_account_tier  = "Standard"
}

module "vmlinux" {
  source = "./modules/vmlinux-n01009389"

  resource_group_name     = module.rgroup.rgroup_name.name
  location                = module.rgroup.rgroup_name.location
  vm_instances            = ["n01009389-u-vm1", "n01009389-u-vm2", "n01009389-u-vm3"]
  size                  = "Standard_B1s"
  admin_username        = "Albin"
  public_key            = "C:\\Users\\Albin\\.ssh\\id_rsa.pub"
  priv_key              = "C:\\Users\\Albin\\.ssh\\id_rsa"
  los_disk_attr         = {
    los_storage_account_type  = "Premium_LRS"
    los_disk_size             = 32
    los_disk_caching          = "ReadWrite"
  }
  linux_publisher        = "OpenLogic"
  linux_offer            = "CentOS"
  linux_sku              = "8_2"
  linux_version          = "latest"
  linux_availability_set = "linux_avs"
  # nb_count               = 2
  subnet_id                = module.network.subnet_id
  boot_diagnostics_storage_account_uri  = "https://tfstaten01009389sa.blob.core.windows.net/tfstatefiles/terraform.tfstate.assignment"
}
# https://tfstaten01009389sa.blob.core.windows.net/tfstatefiles/terraform.tfstate.assignment


module "vmwindows" {
  source = "./modules/vmwindows-n01009389"

  resource_group_name     = module.rgroup.rgroup_name.name
  location                = module.rgroup.rgroup_name.location
  vm_count            = 1
  vm_name             = "n01009389-w-vm"
  vm_size             = "Standard_B1s"
  admin_username        = "Albin"
  admin_password    = "Admin123"
  public_key            = "C:\\Users\\Albin\\.ssh\\id_rsa.pub"
  priv_key              = "C:\\Users\\Albin\\.ssh\\id_rsa"
  wos_disk_attr         = {
    wos_storage_account_type  = "StandardSSD_LRS"
    wos_disk_size             = "128"
    wos_disk_caching          = "ReadWrite"
  }
  windows_publisher        = "MicrosoftWindowsServer"
  windows_offer            = "WindowsServer"
  windows_sku              = "2016-Datacenter"
  windows_version          = "latest"
  windows_availability_set = "linux_avs"
  subnet_id                = module.network.subnet_id
  boot_diagnostics_storage_account_uri  = "https://tfstaten01009389sa.blob.core.windows.net/tfstatefiles/terraform.tfstate"
}

module "datadisk" {
  source = "./modules/datadisk-n01009389"

  resource_group_name  = module.rgroup.rgroup_name.name
  location            = module.rgroup.rgroup_name.location
  disk_count          = 4
  # disk_name           = "n01009389-disk"
  disk_name            = {
    n01009389-dd-1 = "10"
    n01009389-dd-2 = "10"
    n01009389-dd-3 = "10"
  }
  storage_account_type= "Standard"
  # disk_size_gb        = 10
  virtual_machine_id  = [1, 2, 3, 4]
  caching        = "ReadWrite"
}

module "loadbalancer" {
  source = "./modules/loadbalancer-n01009389"

  resource_group_name     = module.rgroup.rgroup_name.name
  location                = module.rgroup.rgroup_name.location
  load_balancer_name  = "n01009389-lb"
  public_ip_name      = "PublicIPAddress"
  vm_ids              = module.vmlinux.vm_instances[*].id
}


module "database" {
  source = "./modules/database-n01009389"

  resource_group_name  = module.rgroup.rgroup_name.name
  location            = module.rgroup.rgroup_name.location
  dbserver_name       = "n01009389-dbserver"
  sku_name            = "B_Gen5_2"
  postgresql_version  = "11"
  admin_username      = "ccgc_admin"
  admin_password      = "admin!PASS_123"
}


