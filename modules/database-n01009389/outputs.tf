output "database_name" {
  description = "Name of the provisioned PostgreSQL server."
  value       = azurerm_postgresql_server.database.name
}
