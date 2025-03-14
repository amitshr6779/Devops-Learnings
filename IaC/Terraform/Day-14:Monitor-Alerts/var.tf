variable "locations" {
  type    = list(string)
  default = ["southcentralus", "northcentralus", "eastus", "westus2"]

}

variable "rg_name" {
  type    = string
  default = "infra-poc-rg"

}

variable "vnet1_name" {
  type    = string
  default = "infra-poc1"

}

variable "subnet1_name" {
  type    = string
  default = "infra-poc1"

}



variable "network_config" {
  type    = tuple([string, string, string, string, number])
  default = ["10.0.0.0/16", "10.0.1.0", "10.1.0.0/16", "10.1.1.0", 24]
}

variable "allowed_ports" {
  type    = string
  default = "80,443,3306,22"
}

variable "allowed_protocol" {
  type    = string
  default = "Tcp,Tcp,Rdp,Ssh"
}

variable "nsg1_name" {
  type    = string
  default = "Vm1-app"

}

