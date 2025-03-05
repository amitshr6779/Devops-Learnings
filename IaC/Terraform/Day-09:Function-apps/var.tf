variable "asp_name" {
    type = string
    default = "poc-asp"
  
}

variable "locations" {
    type = list(string)
    default = [ "southcentralus", "northcentralus", "eastus" , "westus2"]
  
}