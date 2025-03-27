resource "azurerm_resource_group" "prod" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_configs      = var.subnet_configs
  nsg_enabled         = var.nsg_enabled
  nsg_name            = var.nsg_name
}

resource "azurerm_virtual_machine" "prod_vm" {
  name                  = var.vm_name
  location              = azurerm_resource_group.prod.location
  resource_group_name   = azurerm_resource_group.prod.name
  network_interface_ids = [azurerm_network_interface.prod_nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  depends_on = [module.vnet]
}

resource "azurerm_network_interface" "prod_nic" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

output "vm_public_ip" {
  value = azurerm_public_ip.prod_ip.ip_address
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_id" {
  value = module.vnet.subnet_id
}