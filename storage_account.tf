# Creating a new Storage Account in Azure with cross reference to the resource group created in the muiltipleRG.tf file
# This code creates a new storage account in Azure with the name "rackspacepetersa" and associates it with the resource group "rg1".
resource "azurerm_storage_account" "storageaccount" {
  name                     = "rackspacepetersa"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "test"
    cost_center = "paisa wala"
    owner       = "peter bhau"
  }
  
}