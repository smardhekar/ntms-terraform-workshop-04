data "azurerm_key_vault" "kv" {
  name                = "kv-ntms-workshop4"
  resource_group_name = "rg-ntms-kv"
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.kv.id
} 