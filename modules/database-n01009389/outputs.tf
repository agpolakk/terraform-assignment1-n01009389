output "dbserver_name" {
  description = "Name of the provisioned PostgreSQL server."
  value       = azurerm_postgresql_server.dbsever.name
}

output "database_name" {
  description = "Name of the provisioned PostgreSQL server."
  value       = azurerm_postgresql_database.db.name
}
