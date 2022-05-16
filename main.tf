provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~> 2.38.0"
  features {}
  # Should the AzureRM Provider skip registering the Resource
  skip_provider_registration = "true"
}