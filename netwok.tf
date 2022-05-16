resource "azurerm_virtual_network" "main" {
  address_space = ["10.70.0.0/22"]
  location = var.LOCATION
  name = "az104-07-vnet0"
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name = "subnet0"
  resource_group_name = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = ["10.70.0.0/24"]
}