provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dev_rg" {
  name     = "${var.prefix}-dev-rg"
  location = var.location
}

module "vnet" {
  source              = "../../modules/vnet"
  vnet_name          = "${var.prefix}-dev-vnet"
  address_space      = var.address_space
  subnet_configs     = var.subnet_configs
  enable_nsg        = var.enable_nsg
  resource_group_name = azurerm_resource_group.dev_rg.name
}

resource "azurerm_virtual_machine" "dev_vm" {
  name                  = "${var.prefix}-dev-vm"
  location              = azurerm_resource_group.dev_rg.location
  resource_group_name   = azurerm_resource_group.dev_rg.name
  network_interface_ids = [azurerm_network_interface.dev_nic.id]
  vm_size              = var.vm_size

  storage_os_disk {
    name              = "${var.prefix}-dev-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = "${var.prefix}-dev-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "dev_nic" {
  name                = "${var.prefix}-dev-nic"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
  }
}

output "vm_public_ip" {
  value = azurerm_public_ip.dev_ip.ip_address
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}