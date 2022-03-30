variable "resource_group_name" {
  default = "Network"
  type = string
  description = "Resource group name"

}

variable "Environment" {
  description = "The Environment I use"
  type = string
  default = "Production"
}

variable "my_region" {
  description = "Value of the region I use"
  type        = string
  default     = "eastus"
}



