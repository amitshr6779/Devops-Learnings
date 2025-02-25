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

  num = var.vmss_instances
  //value = [for i in range(local.num) : i]

}

resource "azurerm_resource_group" "infra" {
name = "${var.rg_name}-rg"
location = var.locations[0]
}

resource "azurerm_virtual_network" "vnet" {
    name =  "${var.vnet_name}-vnet"
    address_space = [var.network_config[0]]
    location = azurerm_resource_group.infra.location
    resource_group_name = azurerm_resource_group.infra.name
  
}


resource "azurerm_subnet" "subnet" {
    name = "${var.subnet_name}-subnet"
    resource_group_name = azurerm_resource_group.infra.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [ "${var.network_config[1]}/${var.network_config[2]}" ]
}

resource "azurerm_network_security_group" "nsg" {
    name = "${var.nsg_name}-nsg"
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

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.public_ip_name}-ip"
  location = azurerm_resource_group.infra.location
  resource_group_name = azurerm_resource_group.infra.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location = azurerm_resource_group.infra.location
  resource_group_name = azurerm_resource_group.infra.name
  sku                 = "Standard"  

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}


resource "azurerm_nat_gateway" "nat" {
  name                =  var.nat_gateway_name
  location = azurerm_resource_group.infra.location
  resource_group_name = azurerm_resource_group.infra.name
}

resource "azurerm_subnet_nat_gateway_association" "nat_assoc" {
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

resource "azurerm_public_ip_prefix" "vmss_prefix" {
  name                = "${var.vmss_name}-public-ip-prefix"
  //count               = local.num
  //name                = "${var.vmss_name}-public-ip-prefix-${count.index}"
  location            = azurerm_resource_group.infra.location
  resource_group_name = azurerm_resource_group.infra.name
  prefix_length       = 30  # Adjust the size as per requirement
  sku                 = "Standard"
}


resource "azurerm_linux_virtual_machine_scale_set" "vmss" {

  name                = var.vmss_name
  location            = azurerm_resource_group.infra.location
  resource_group_name = azurerm_resource_group.infra.name
  sku                 = var.vmss_sku
  instances           = var.vmss_instances

  # ✅ Use only `source_image_reference`
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # ✅ Use `admin_username` & `admin_ssh_key`
  admin_username = "adminuser"
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  # ✅ Use `os_disk` instead of `storage_os_disk`
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "nic1"
    primary = true

    ip_configuration {
      name      = "ipconfig1"
      primary   = true
      subnet_id = azurerm_subnet.subnet.id

      public_ip_address {
      name = "${var.vmss_name}-public-ip"
      public_ip_prefix_id = azurerm_public_ip_prefix.vmss_prefix.id  # ✅ Attach Standard SKU IP Prefix

    }
  }
}
}


