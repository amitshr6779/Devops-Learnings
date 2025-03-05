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


variable "public_ip_names" {
  type    = list(string)
  default = ["vm1-public-ip"]
}

# Create multiple Public IPs using count
resource "azurerm_public_ip" "public_ip" {
  //count               = length(var.public_ip_names)
  //name                = var.public_ip_names[count.index]
  name                = var.public_ip_names[0]
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
    public_ip_address_id          = azurerm_public_ip.public_ip.id

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

resource "null_resource" "deployment_prep" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "echo 'Deployment started at ${timestamp()}' > deployment-timestamp.log"
  }
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

    provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "echo 'Hello, Nginx!' > /var/www/html/index.html",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type     = "ssh"
      user     = "adminuser"
      private_key = file("~/.ssh/id_rsa")
      host        =  azurerm_public_ip.public_ip.ip_address
    }
  }


    provisioner "file" {
    source = "./var.tf"
    destination = "/home/adminuser/var.tf"

    connection {
        type = "ssh"
        user = "adminuser"
        private_key = file("~/.ssh/id_rsa")
        host     = azurerm_public_ip.public_ip.ip_address
      }
    
  }
  depends_on = [azurerm_public_ip.public_ip]
}