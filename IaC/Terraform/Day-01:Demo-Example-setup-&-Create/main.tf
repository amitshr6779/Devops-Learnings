resource "azurerm_resource_group" "example" {
  name     = "poc-resources"
  location = "South Central US"
  tags = {
    "environment" = "tf"
  }

}