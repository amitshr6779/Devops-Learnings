resource "azurerm_resource_group" "example" {
  name     = "${var.environment}-resources"
  location =  var.location[0]
  tags = {
    "environment" = "tf"
  }
}


resource "azurerm_virtual_network" "main" {
  name                = "${var.environment}-network"
  address_space       = [element(var.network_config,0)]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
    name               = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["${element(var.network_config, 1)}/${element(var.network_config, 2)}"]

}


resource "azurerm_network_interface" "main" {
  name                = "${var.environment}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "pocconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.environment}-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.allowed_vm_sizes[0]

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = var.is_delete

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.vm_config.sku
    version   = var.vm_config.version
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb =    var.storage_disk
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.resource_tags["environment"]
    managed_by = var.resource_tags["managed_by"]
    department = var.resource_tags["department"]
  }
}

resource "azurerm_storage_account" "example" {
  #list wiorks with list type 
  #count = length(var.storage_account_name)
  #name = var.storage_account_name[count.index]

  #for_each works with set type
  for_each = var.storage_account_name
  name                     = each.value
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.resource_tags["environment"]
  }
}


# Create Network Security Group
resource "azurerm_network_security_group" "example" {
  //conditional expression
  name                = var.environment == "dev" ? "poc-dev-nsg" : "poc-stage-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.destination_port_range
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}


