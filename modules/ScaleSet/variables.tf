variable "resource_group_name" {
  default = "ScaleSet"
  type = string
  description = "Resource group name"

}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}

variable "AppSubnetID" {
    description = "Application subnetID"
}

variable "lb_backend_address_pool_id" {
  description = "Load Balancer address pool ID for vmss"
}

variable "Environment" {
  description = "The Environment I use"
  type = string
  default = "Production"
}

variable "Password" {
  type = string
  description = "Password for vm"
  default = "ItsNotTheRealPassword!123"

}