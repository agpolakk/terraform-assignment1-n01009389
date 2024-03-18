resource "azurerm_postgresql_server" "dbsever" {
  name                        = var.dbserver_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  sku_name                    = var.sku_name
  version                     = var.postgresql_version
  administrator_login         = var.admin_username
  administrator_login_password= var.admin_password
  storage_mb                  = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  ssl_enforcement_enabled     = true
  public_network_access_enabled    = false
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "db" {
  name                = "n01009389-database"
  resource_group_name = var.resource_group_name
  # server_name         = azurerm_postgresql_server.dbserver.name
  server_name         = azurerm_postgresql_server.dbsever.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
