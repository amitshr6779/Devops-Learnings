variable "locations" {
    type = list(string)
    default = [ "southcentralus", "northcentralus", "eastus" , "westus2"]
  
}

variable "rg_name" {
    type = string
    default = "infra-poc-rg"
  
}