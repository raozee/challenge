variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network in CIDR notation."
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnet configurations."
  type = map(object({
    name           = string
    address_prefix = string
    nsg_id         = optional(string)  # Optional Network Security Group ID
  }))
}

variable "location" {
  description = "The Azure region where the VNET will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}