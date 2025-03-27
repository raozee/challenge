resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  count               = length(var.subnet_configs)
  name                = element(var.subnet_configs, count.index).name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefix      = element(var.subnet_configs, count.index).address_prefix

  depends_on = [azurerm_virtual_network.this]
}

resource "azurerm_network_security_group" "this" {
  count               = var.enable_nsg ? 1 : 0
  name                = "${var.vnet_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count                  = var.enable_nsg ? length(var.subnet_configs) : 0
  subnet_id              = azurerm_subnet.this[count.index].id
  network_security_group_id = azurerm_network_security_group.this[0].id
}

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  value = azurerm_subnet.this[*].id
}

output "nsg_id" {
  value = var.enable_nsg ? azurerm_network_security_group.this[0].id : null
}