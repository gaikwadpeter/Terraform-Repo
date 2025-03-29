# storage_account.tf

resource "azurerm_storage_container" "sa_container" {
    name                  = "rackspacecontainer"
    storage_account_name  = azurerm_storage_account.storageaccount.name
    container_access_type = "private"
}