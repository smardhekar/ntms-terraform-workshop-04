resource "azurerm_virtual_network" "vnet" {
  name                = "${var.env}-${var.project-owner}-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.add_space

  tags = {
    env    = var.env
    module = "network"
  }
}


resource "azurerm_subnet" "snet" {
  name                 = "${var.env}-${var.project-owner}-snet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.sub_pre
}