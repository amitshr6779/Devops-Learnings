variable "rg_name" {
    type = string
    default = "infra-poc"
  
}

variable "vnet_name" {
    type = string
    default = "infra-poc"
  
}

variable "subnet_name" {
    type = string
    default = "infra-poc"
  
}

variable "nsg_name" {
    type = string
    default = "test-app"
  
}

variable "public_ip_name" {
    type = string
    default = "poc-public"
  
}

variable "lb_name" {
    type = string
    default = "poc-lb"
  
}

variable "nat_gateway_name" {
    type = string
    default = "poc-nat"
}

variable "vmss_name" {
    default = "poc-vmss"
    type = string
  
}

variable "vmss_sku" {
    type = string
    default = "Standard_DS1_v2"
}

variable "vmss_instances" {
    type = number
    default = 2
  
}

variable "locations" {
    type = list(string)
    default = [ "southcentralus", "northcentralus", "eastus" , "westus2"]
  
}

variable "allowed_ports" {
  type = string
  default = "80,443,3306,22"
}

variable "allowed_protocol" {
  type = string
  default = "Tcp,Tcp,Rdp,Ssh"
}


variable "network_config" {
    type = tuple([ string, string, number ])
    default = [ "10.0.0.0/16", "10.0.1.0", 24 ]
}

