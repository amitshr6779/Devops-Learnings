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

resource "azurerm_linux_web_app" "node_app" {
  name                = "nodeapp02"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  location            = var.locations[0]
  service_plan_id     = azurerm_service_plan.asp.id
  https_only                    = true
  public_network_access_enabled = false
  virtual_network_subnet_id     = data.azurerm_subnet.subnet_shared.id


  site_config {
    application_stack{
      node_version = "18-lts"
    }
  }
}



resource "azurerm_private_dns_zone" "static_web" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
}


resource "azurerm_private_endpoint" "nodeapp02-pe" {
  name                = "nodeapp02-pe"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
  location            = var.locations[0]
  subnet_id           = data.azurerm_subnet.subnet_shared2.id

  private_service_connection {
    name                           = "nodeapp02-connection"
    private_connection_resource_id = azurerm_linux_web_app.node_app.id
    subresource_names              = ["sites"]  # Use correct subresource type
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "nodeapp02-dns-group"  # Use a unique name (not the web app name)
    private_dns_zone_ids = [resource.azurerm_private_dns_zone.static_web.id]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_vnet_A" {
  name                  = "link-vnet-A"
  resource_group_name   = data.azurerm_resource_group.rg_shared.name
  private_dns_zone_name = azurerm_private_dns_zone.static_web.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_shared.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_vnet_B" {
  name                  = "link-vnet-b"
  resource_group_name   = data.azurerm_resource_group.rg_shared.name
  private_dns_zone_name = azurerm_private_dns_zone.static_web.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_shared2.id
}




