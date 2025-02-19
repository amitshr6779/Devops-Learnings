resource "azurerm_resource_group" "example" {
  name     = "poc-resources"
  location = var.location
  tags = {
    "environment" = "tf"
  }
}

resource "azurerm_storage_account" "example" {
 
  name                     = "pocstorage1"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.common_tags.environment
  }
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
}
