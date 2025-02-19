variable "location" {
    type = string
    description = "the env type"
    default = "South Central US"
  
}

locals {
  common_tags = {
    environment = "poc-tf"
    lob = "banking"
    stage = "alpha"
  }
}