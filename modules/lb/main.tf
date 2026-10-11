#pip = std pip
resource "azurerm_public_ip" "pip" {
  name                = "${var.env}-${var.project-owner}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#external lb
resource "azurerm_lb" "lb" {
  name                = "${var.env}-${var.project-owner}-lb"
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = "${var.env}-${var.project-owner}-fe"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  tags = {
    env    = var.env
    module = "lb"
  }
}

# bp -  vm to be registered with lb
resource "azurerm_lb_backend_address_pool" "bp" {
  name            = "${var.env}-${var.project-owner}-bp"
  loadbalancer_id = azurerm_lb.lb.id
}

#hp    
resource "azurerm_lb_probe" "hp" {
  name            = "${var.env}-${var.project-owner}-hp"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

#lb rule
resource "azurerm_lb_rule" "lbrule" {
  name            = "${var.env}-${var.project-owner}-lbrule"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Tcp"
  frontend_port   = 80
  backend_port    = 80
  #frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  frontend_ip_configuration_name = "${var.env}-${var.project-owner}-fe"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bp.id]
  probe_id                       = azurerm_lb_probe.hp.id
}

#nic-bp-association
resource "azurerm_network_interface_backend_address_pool_association" "nic-bp-association" {
  count                   = var.vm_count
  network_interface_id    = var.nic_ids[count.index]
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bp.id
}