variable "locations" {
    type = list(string)
    default = [ "southcentralus", "northcentralus", "eastus" , "westus2"]
  
}

variable "rg_name" {
    type = string
    default = "infra-poc"
  
}
variable "service_principal_name" {
    type = string
    default = "test-spn-poc"
  
}

variable "SUB_ID" {
  type = string
  default = "c8c0574f-6d3f-4c1a-8d5d-de15c56203be"
}



variable "client_id" {
    type = string
    default = "44ce13d8"
  
}
variable "client_secret" {
    type = string
    default = "v"
  
}

variable "kv_name" {
    type = string
    default = "poc-kv"
  
}