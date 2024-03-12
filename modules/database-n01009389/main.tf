resource "azurerm_postgresql_server" "database" {
  name                        = var.database_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  sku_name                    = var.sku_name
  version                     = var.postgresql_version
  administrator_login         = var.admin_username
  administrator_login_password= var.admin_password
  ssl_enforcement_enabled     = true
}

# output "database_name" {
#   value = azurerm_postgresql_server.database.name
# }
