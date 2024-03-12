variable "load_balancer_name" {
  description = "Name of the load balancer."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP address."
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

variable "vm_ids" {
  description = "List of VM IDs to associate with the load balancer."
  type        = list(string)
}

# variable "frontend_ip_configuration_name" {

# }
