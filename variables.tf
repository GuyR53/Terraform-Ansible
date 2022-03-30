
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
variable "size" {
  description = "Size for the ansible controler machine"
  default = "Standard_D2ads_v5"
}
variable "sku" {
  description = "sku for scaleset"
  default = "Standard_D2ads_v5"
}
variable "Instances" {
  description = "Instances for the scaleset"
  default = 2
}
variable "default" {
  default = 2
  description = "default machines for the scaleset"
}
variable "minimum" {
  default = 2
  description = "minimum machines for the scaleset"
}
variable "Password" {
  type = string
  description = "Password for vm"
  default = "ItsNotTheRealPassword!123"
}

