locals {
  port = split(",", var.allowed_ports)
  protocol = split(",", var.allowed_protocol)

  nsg_ports = [for index, i in local.port : {
    name = "port-${i}"
    port = i
    protocol = length(local.protocol) > index ? local.protocol[index] : "Tcp" # Default to TCP if protocol list is shorter

  }]

  nsg_protocol = [
    for i  in local.protocol : {
        portocol : i
    }
  ]

}

resource "azurerm_resource_group" "infra" {
name = "${var.rg_name}-rg"
location = var.locations[0]
}

resource "azurerm_virtual_network" "vnet-A" {
    name =  "${var.vnet1_name}-vnet"
    address_space = [var.network_config[0]]
    location = azurerm_resource_group.infra.location
    resource_group_name = azurerm_resource_group.infra.name
  
}


resource "azurerm_subnet" "subnet-A" {
    name = "${var.subnet1_name}-subnet"
    resource_group_name = azurerm_resource_group.infra.name
    virtual_network_name = azurerm_virtual_network.vnet-A.name
    address_prefixes = [ "${var.network_config[1]}/${var.network_config[4]}" ]
    depends_on = [azurerm_virtual_network.vnet-A]
}


resource "azurerm_virtual_network" "vnet-B" {
    name =  "${var.vnet2_name}-vnet"
    address_space = [var.network_config[2]]
    location = azurerm_resource_group.infra.location
    resource_group_name = azurerm_resource_group.infra.name
  
}


resource "azurerm_subnet" "subnet-B" {
    name = "${var.subnet2_name}-subnet"
    resource_group_name = azurerm_resource_group.infra.name
    virtual_network_name = azurerm_virtual_network.vnet-B.name
    address_prefixes = [ "${var.network_config[3]}/${var.network_config[4]}" ]
    depends_on = [azurerm_virtual_network.vnet-B]
}


resource "azurerm_virtual_network_peering" "peerA_to_peerB" {
  name                      = "peerA-to-peerB"
  resource_group_name = azurerm_resource_group.infra.name  
  virtual_network_name      = azurerm_virtual_network.vnet-A.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-B.id
}

resource "azurerm_virtual_network_peering" "peerB_to_peerA" {
  name                      = "peerB-to-peerA"
  resource_group_name       = azurerm_resource_group.infra.name  
  virtual_network_name      = azurerm_virtual_network.vnet-B.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-A.id
}


variable "public_ip_names" {
  type    = list(string)
  default = ["vm1-public-ip", "vm2-public-ip"]
}

# Create multiple Public IPs using count
resource "azurerm_public_ip" "public_ip" {
  count               = length(var.public_ip_names)
  name                = var.public_ip_names[count.index]
  location            =  azurerm_resource_group.infra.location
  resource_group_name       = azurerm_resource_group.infra.name  
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_network_interface" "nic1" {
  //count               = length(var.public_ip_names)
  //name                = "my-nic-${count.index}"
  name                = "my-nic-1"
  location            =  azurerm_resource_group.infra.location
  resource_group_name       = azurerm_resource_group.infra.name  

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-A.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[0].id

  }
}

resource "azurerm_network_interface" "nic2" {
  //count               = length(var.public_ip_names)
  //name                = "my-nic-${count.index}"
  name                = "my-nic-2"
  location            =  azurerm_resource_group.infra.location
  resource_group_name       = azurerm_resource_group.infra.name  

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-B.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[1].id

  }
}


resource "azurerm_network_security_group" "nsg1" {
    name = "${var.nsg1_name}-nsg"
    location = azurerm_resource_group.infra.location
    resource_group_name = azurerm_resource_group.infra.name
    dynamic "security_rule" {
        for_each = local.nsg_ports
    content {

      name                       = "${security_rule.value.protocol}-${security_rule.value.port}"
      priority                   = 100 + index(local.nsg_ports, security_rule.value)
      direction                  = "Inbound"
      access                     = "Allow"
      //protocol                 = security_rule.value.protocol
      protocol                   = "Tcp" 
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"        
      
    }
      
    }  
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc1" {
  subnet_id                 = azurerm_subnet.subnet-A.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc2" {
  subnet_id                 = azurerm_subnet.subnet-B.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}


resource "azurerm_virtual_machine" "vm" {
  name                  = "my-vm"
  location            =  azurerm_resource_group.infra.location
  resource_group_name       = azurerm_resource_group.infra.name  
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = "Standard_DS1_v2"
    delete_os_disk_on_termination = true


  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "my-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "my-vm"
    admin_username = "adminuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true # Disable password login
    ssh_keys {
      path     = "/home/adminuser/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub") # Path to your public SSH key
    }
  }
}

resource "azurerm_virtual_machine" "vm2" {
  name                  = "my-vm2"
  location            =  azurerm_resource_group.infra.location
  resource_group_name       = azurerm_resource_group.infra.name  
  network_interface_ids = [azurerm_network_interface.nic2.id]
  vm_size               = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "my-os-disk-vm2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "my-vm"
    admin_username = "adminuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true # Disable password login
    ssh_keys {
      path     = "/home/adminuser/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub") # Path to your public SSH key
    }
  }
}







