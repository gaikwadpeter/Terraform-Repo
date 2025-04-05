# Create an Resource group
resource "azurerm_resource_group" "multirg1" {
  name     = "terraform-rg1"
  location = "central india"
  tags = {
    environment = "test"
    cost_center = "paisa wala"
    owner       = "peter bhau"
}
}
resource "azurerm_resource_group" "multirg2" {
  name     = "terraform-rg2"
  location = "central india"
  tags = {
    environment = "test"
    cost_center = "paisa wala"
    owner       = "peter bhau"
}
}

resource "azurerm_resource_group" "multirg3" {
  name     = "terraform-rg3"
  location = "central india"
  tags = {
    environment = "test"
    cost_center = "paisa wala"
    owner       = "peter bhau"
}

}