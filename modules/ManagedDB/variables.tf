variable "resource_group_name" {
  default = "ManagedDB"
  type = string
  description = "Resource group name"

}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}

variable "VirtualNetworkID" {
   description = "Virtual network ID"
}


variable "DBSubnet" {
  description = "Database subnetID (private subnet)"
}

variable "Environment" {
  description = "The Environment I use"
  type = string
  default = "Production"
}

variable "Password" {
  type = string
  description = "Password for db"
  default = "ItsNotTheRealPassword!123"

}