variable "vnet_name" {
  description = "The name of the Azure Virtual Network."
  type        = string
}

variable "address_space" {
  description = "The address space for the Virtual Network in CIDR format."
  type        = list(string)
}

variable "subnet_configs" {
  description = "A list of subnet configurations."
  type        = list(object({
    name           = string
    address_prefix = string
    nsg_id         = optional(string)
  }))
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group where the VNET will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}