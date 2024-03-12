resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
}

resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = var.recovery_services_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku = var.log_analytics_sku
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = "LRS"
}

# output "log_analytics_name" {
#   value = azurerm_log_analytics_workspace.log_analytics.name
# }

# output "recovery_services_vault_name" {
#   value = azurerm_recovery_services_vault.recovery_services_vault.name
# }

# output "storage_account_name" {
#   value = azurerm_storage_account.storage_account.name
# }
