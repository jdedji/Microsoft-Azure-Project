resource "azurerm_key_vault" "keyvault" {
  location = azurerm_resource_group.rg.location
  name = "azuredbkv1297"
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"

}

resource "azurerm_key_vault_access_policy" "kv" {
  object_id = data.azurerm_client_config.current.object_id
  tenant_id = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id
  secret_permissions = ["delete","get","list","set"]
}

//
resource "databricks_secret_scope" "kv" {
  name = "keyvault-viaTf"
  keyvault_metadata {
    resource_id = azurerm_key_vault.keyvault.id
    dns_name = azurerm_key_vault.keyvault.vault_uri
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name = "azuredb-storage"
  value = azurerm_storage_account.storage.primary_access_key
  key_vault_id = azurerm_key_vault.keyvault.id
}
