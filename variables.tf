variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "South India"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Subnets to be created inside the VNet"
  type        = map(string)
  default = {
    management  = "10.0.0.0/24"
    application = "10.0.1.0/24"
    database    = "10.0.2.0/24"
  }
}