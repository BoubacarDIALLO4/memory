//resource "azurerm_resource_group" "main"{
//  name = "az104-07-rg0"
//  location = var.LOCATION
//}

data "azurerm_resource_group" "main" {
  name = "rg-inf-test"
}