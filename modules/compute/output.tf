output "vm_id" {
  value = azurerm_windows_virtual_machine.vm[*].id
}

output "vm_names" {
  value = azurerm_windows_virtual_machine.vm[*].name
}

output "private_ips" {
  value = azurerm_network_interface.nic[*].private_ip_address
}

output "nic_ids" {
  value = azurerm_network_interface.nic[*].id
}