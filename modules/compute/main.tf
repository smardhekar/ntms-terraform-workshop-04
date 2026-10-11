#nic
resource "azurerm_network_interface" "nic" {
  name                = "${var.env}-${var.project-owner}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  count = var.vm_count
}

resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "${var.env}-${var.project-owner}-vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.rg_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]
  os_disk {
    name                 = "${var.env}-${var.project-owner}-${count.index + 1}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  tags = {
    env    = var.env
    module = "compute"
  }
}

resource "azurerm_virtual_machine_extension" "iis" {
  count = var.vm_count
  name  = "install-iis"
  #name                = "${var.env}-${var.project-owner}-vmext-${count.index + 1}"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = jsonencode({
    commandToExecute = "powershell -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -Name Web-Server -IncludeManagementTools; Set-Content -Path C:\\inetpub\\wwwroot\\Default.htm -Value $env:COMPUTERNAME\""
  })

  tags = {
    environment = var.env
  }
}

