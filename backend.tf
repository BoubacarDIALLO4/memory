//terraform {
//  backend "azurerm" {
//    resource_group_name  = "rg-sbx-diallobo"
//    storage_account_name = "bouba"
//    container_name       = "tfstate-bouba"
//    key                  = "fcm-assemblycheck-local.tfstate"
//  }
//}
//
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}