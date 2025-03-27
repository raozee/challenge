variable "vnet_name" {
  description = "The name of the Azure Virtual Network."
  type        = string
  default     = "dev-vnet"
}

variable "address_space" {
  description = "The address space for the Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "A list of subnet prefixes for the Virtual Network."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "East US"
}

variable "enable_nsg" {
  description = "Enable Network Security Group for the subnets."
  type        = bool
  default     = true
}

variable "nsg_rules" {
  description = "List of NSG rules to apply if NSG is enabled."
  type        = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_address_prefix      = string
    destination_address_prefix = string
    source_port_range          = string
    destination_port_range     = string
  }))
  default     = []
}