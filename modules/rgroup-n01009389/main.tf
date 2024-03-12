resource "azurerm_resource_group" "rgroup" {
  name     = var.resource_group_name
  location = var.location
}

