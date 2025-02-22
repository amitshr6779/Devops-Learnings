//virtual machine (VM) in the shared vnet and a specific subnet (subnet6) without creating new resources.

# Data source for the existing Resource Group
data "azurerm_resource_group" "rg_shared" {
  name = "shared-network-rg"
}

# Data source for the existing Virtual Network
data "azurerm_virtual_network" "vnet_shared" {
  name                = "shared-network-vnet"
  resource_group_name = data.azurerm_resource_group.rg_shared.name
}

# Data source for the existing Subnet
data "azurerm_subnet" "subnet_shared" {
  name                 = "shared-primary-sn"
  virtual_network_name = data.azurerm_virtual_network.vnet_shared.name
  resource_group_name  = data.azurerm_resource_group.rg_shared.name
}

# Create a new Resource Group for the VM
resource "azurerm_resource_group" "rg" {
  name     = "day13-rg"
  location = data.azurerm_resource_group.rg_shared.location
}

# Create a Network Interface using the existing subnet
resource "azurerm_network_interface" "nic" {
  name                = "day13-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_shared.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "day13-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "day13-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "day13-vm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}