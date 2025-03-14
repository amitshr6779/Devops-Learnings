
resource azurerm_resource_group "rg"{
  name = var.rg_name
  location = var.locations[0]
}

resource "azurerm_mssql_server" "example" {
  name                         = "pocmssqlserver67"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqlserveradmin"
  administrator_login_password = "thisIssk@1716gx180"
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "no-iris-pdev-sc"
    //object_id      = "4635b9e8-cfcf-48e6-a8c3-d2ca85837c94"
    object_id = "fba4f174-9254-45da-a9e5-7da02bddda3e"
  }

  tags = {
    environment = "for-poc"
  }
}


resource "azurerm_mssql_database" "example" {

  name         = "poc-ai-db"
  server_id      = azurerm_mssql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "S0"
  max_size_gb    = 10

  #license_type   = "LicenseIncluded"
  #read_scale     = true
  #zone_redundant = true
  #enclave_type   = "VBS"  # supports in Premium sku tier

}



