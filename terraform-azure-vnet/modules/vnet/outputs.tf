output "vnet_id" {
  description = "The ID of the created Virtual Network."
  value       = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  description = "The IDs of the created subnets."
  value       = azurerm_subnet.main.*.id
}

output "vnet_name" {
  description = "The name of the created Virtual Network."
  value       = azurerm_virtual_network.main.name
}

output "subnet_names" {
  description = "The names of the created subnets."
  value       = azurerm_subnet.main.*.name
}

output "address_space" {
  description = "The address space of the Virtual Network."
  value       = azurerm_virtual_network.main.address_space
}