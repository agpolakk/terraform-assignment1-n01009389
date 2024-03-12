variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the virtual network."
  type        = list(string)
}

variable "location" {
  description = "Location of the resources."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address prefixes of the subnet."
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the network security group."
  type        = string
}
