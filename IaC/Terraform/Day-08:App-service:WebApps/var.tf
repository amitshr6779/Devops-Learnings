variable "locations" {
    type = list(string)
    default = [ "southcentralus", "northcentralus", "eastus" , "westus2"]
  
}

variable "rg_name" {
    type = string
    default = "infra-poc"
  
}

variable "vnet1_name" {
    type = string
    default = "infra-poc1"
  
}

variable "subnet1_name" {
    type = string
    default = "infra-poc1"
  
}

variable "vnet2_name" {
    type = string
    default = "infra-poc2"
  
}

variable "subnet2_name" {
    type = string
    default = "infra-poc2"
  
}


variable "asp_name" {
    type = string
    default = "poc-asp"
  
}