variable "database_name" {
  description = "Name of the PostgreSQL server."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Location of the resources."
  type        = string
}

variable "sku_name" {
  description = "SKU name of the PostgreSQL server."
  type        = string
}

variable "postgresql_version" {
  description = "Version of PostgreSQL."
  type        = string
}

variable "admin_username" {
  description = "Administrator username for the PostgreSQL server."
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the PostgreSQL server."
  type        = string
}
