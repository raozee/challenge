output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}

output "public_ip" {
  value = azurerm_public_ip.vm_public_ip.ip_address
}

output "vm_id" {
  value = azurerm_virtual_machine.dev_vm.id
}