locals {
  rgname = lower(replace(var.project_name, " ", "-"))
  tags  = merge(var.def_tags, var.custom_tags)

  //substr, Extracts the first 15 characters from
  formatted_sa_name =  lower(replace(substr(var.storage_account_name, 0,15), " " ,""))

//split() function takes a delimiter (",") and splits the string into multiple elements, producing a list of strings:
//The split() function in Terraform always returns a list.
  ports = split(",",(var.allowed_ports))

 //objects can hold lists, maps, nested objects, or any other data type 
  //Creates an object (map) for each port, Stores all objects inside a list
  nsg_ports = [for i in local.ports :  {
    name = "port-${i}"
    port = i 
  }]

  //lookup function retrieves a value from a map based on a given key. If the key does not exist, it returns a default value. here, 1st args is map values, 2nd args is key, & 3rd is default value
  vm_size = lookup(var.vm_size, var. environment, "Standard_D2s_v3")

  //Use the fileexists function to check if a file exists at a given path.
  config_exists = fileexists("${path.module}/config.json")

  //securely read and validate JSON file content.
  //config_content	Stores the raw JSON file contents as a sensitive string.
  //config_parsed	Uses jsondecode() to convert the JSON string into a Terraform map/object for structured access.
  config_content = sensitive(file("${path.module}/config.json"))
  config_parsed  = jsondecode(local.config_content)

  
  //Use concat to merge two lists.
  //Use toset to remove duplicates.
  user_locations     = ["eastus", "westus", "eastus"]
  default_locations = ["centralus"]
  unique_locations  = toset(concat(local.user_locations, local.default_locations))

  
}

resource "azurerm_resource_group" "exmaple"{
    name = local.rgname
    location = "south central us"
    tags = local.tags
}

resource "azurerm_network_security_group" "nsg" {
    name = "app-nsg"
    resource_group_name = azurerm_resource_group.exmaple.name
    location = azurerm_resource_group.exmaple.location
    
    dynamic "security_rule" {
        for_each = local.nsg_ports
    content {
      name                       = security_rule.value.name
      priority                   = 100 + index(local.nsg_ports, security_rule.value)
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    }
  
}