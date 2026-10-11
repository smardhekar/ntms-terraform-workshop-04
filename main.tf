resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-${var.project-owner}-rg"
  location = var.location
}

#module1 == network
module "network" {
  source        = "./modules/network"
  env           = var.env
  location      = var.location
  rg_name       = azurerm_resource_group.rg.name
  project-owner = var.project-owner
  add_space     = ["10.1.0.0/16"]
  sub_pre       = ["10.1.1.0/24"]
}

#module2 == security
module "security" {
  source        = "./modules/security"
  env           = var.env
  location      = var.location
  rg_name       = azurerm_resource_group.rg.name
  project-owner = var.project-owner
  subnet_id     = module.network.snet_id
}

#module3 == compute
module "compute" {
  source         = "./modules/compute"
  env            = var.env
  location       = var.location
  rg_name        = azurerm_resource_group.rg.name
  project-owner  = var.project-owner
  subnet_id      = module.network.snet_id
  admin_username = var.admin_username
  admin_password = data.azurerm_key_vault_secret.vm_password.value
  vm_count       = var.vm_count
}

#module4 == lb
module "lb" {
  source        = "./modules/lb"
  env           = var.env
  location      = var.location
  rg_name       = azurerm_resource_group.rg.name
  project-owner = var.project-owner
  nic_ids       = module.compute.nic_ids
  vm_count      = var.vm_count
}