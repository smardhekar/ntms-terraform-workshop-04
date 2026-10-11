#nsg
resource "azurerm_network_security_group" "nsg" {
  name                = "samir-nsg1"
  location            = var.location
  resource_group_name = var.rg_name
}


#nsg-rule
resource "azurerm_network_security_rule" "http" {
  name                        = "test123"
  priority                    = 300
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "http1" {
  name                        = "allow-http"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


#nsg-subnet-asso
resource "azurerm_subnet_network_security_group_association" "nsg-sub" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}