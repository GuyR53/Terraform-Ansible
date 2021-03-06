variable "resource_group_name" {
  default = "AppServer"
  type = string
  description = "Resource group name"

}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}
variable "size" {
  description = "size of machine"
  default = "Standard_DS2_v2"
}

variable "vm_names" {
  type = list
  description = "List of machines to create with their names"
}
variable "AppSubnetID" {
    description = "Application subnetID"
}

variable "Password" {
  type = string
  description = "Password for vm"
  default = "ItsNotTheRealPassword!123"

}

variable "Environment" {
  description = "The Environment I use"
  type = string
  default = "Production"
}


# Getting the index of the configuration machine to make publicIPAddress
locals {
  MachinewithIP="${length(var.vm_names)-1}"
}

