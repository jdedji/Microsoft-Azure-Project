resource "azurerm_storage_account" "storage" {
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = azurerm_resource_group.rg.location
  name = "azuredbob1289"
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_storage_container" "container" {
  name = "azuredbcontainer"
  storage_account_name = azurerm_storage_account.storage.name
}