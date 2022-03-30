variable "resource_group_name" {
  default = "LoadBalancer"
  type = string
  description = "Resource group name"

}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}

variable "Environment" {
  description = "The Environment I use"
  type = string
  default = "Production"
}



