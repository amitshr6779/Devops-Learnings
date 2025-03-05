data "azurerm_resource_group" "rg_shared" {
  name = "infra-poc-rg"
}

# Data source for the existing Virtual Network
data "azurerm_virtual_network" "vnet_shared" {
  name                = "infra-poc1-vnet"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
}

data "azurerm_virtual_network" "vnet_shared2" {
  name                = "infra-poc2-vnet"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
}

# Data source for the existing Subnet
data "azurerm_subnet" "subnet_shared" {
  name                 = "infra-poc1-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet_shared.name
  resource_group_name  = data.azurerm_resource_group.rg_shared.name
}

/*Subnet for Private Endpoint */
data "azurerm_subnet" "subnet_shared2" {
  name                 = "infra-poc02-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet_shared.name
  resource_group_name  = data.azurerm_resource_group.rg_shared.name
}

/*
resource "azurerm_resource_group" "infra" {
name = "${var.rg_name}-rg"
location = var.locations[0]
}
*/

resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  location            = var.locations[0]
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_function_app" "example" {
  name                = "node-qr-function-app"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  location            = var.locations[0]

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.asp.id

  https_only                    = true
  public_network_access_enabled = false
  virtual_network_subnet_id     = data.azurerm_subnet.subnet_shared.id

  site_config {
    application_stack{
      node_version = "18"
    }

  }
  depends_on = [ azurerm_storage_account.example ]
}


resource "azurerm_storage_account" "example" {
  name                     = "linuxfunctionappsapoc"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  location            = var.locations[0]
  account_tier             = "Standard"
  account_replication_type = "LRS"
}