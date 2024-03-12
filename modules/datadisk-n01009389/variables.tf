variable "disk_count" {
  description = "Number of data disks to create."
  type        = number
}

variable "disk_name" {
  description = "Base name for the data disks."
  type        = map(string)
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Location of the resources."
  type        = string
}

variable "storage_account_type" {
  description = "Storage account type for the data disks."
  type        = string
}

# variable "disk_size_gb" {
#   description = "Size of the data disks in GB."
#   type        = number
# }

variable "virtual_machine_id" {
  description = "List of virtual machine IDs to attach the data disks."
  type        = list(string)
}

variable "caching" {
  
}