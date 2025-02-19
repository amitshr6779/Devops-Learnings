variable "environment" {
  type = string
  default = "poc"
}

variable "storage_disk" {
    type = number
    description = "the storage disk size of os"
    default = 80
}


variable "location" {
  type = list(string)
  description = "list of reqions"
  default = [ "South Central US", "North Central US" ]
  
}

 variable "network_config" {
  type = tuple([string, string , number])
  description = "Network configuration (VNET address, subnet address, subnet mask)"
  default = ["10.0.0.0/16", "10.0.2.0", 24]
 }


variable "allowed_vm_sizes" {
  type = list(string)
  default     = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]
  
}

variable "is_delete" {
  type = bool
  default = true
  
}

variable "vm_config" {
  type = object({
    size         = string
    publisher    = string
    offer        = string
    sku          = string
    version      = string
  })
  description = "value"
  default = {
    size         = "Standard_DS1_v2"
    publisher    = "Canonical"
    offer        = "0001-com-ubuntu-server-jammy"
    sku          = "22_04-lts"
    version      = "latest"
  }
}


variable "resource_tags" {
  type = map(string)
  default = {
      "environment" = "staging"
      "managed_by" = "terraform"
      "department" = "devops"
  }

}

variable "storage_account_name" {
  type = set(string)
  default = [ "pocsa67", "pocsa68" , "pocsa70" ]
  
}

variable "list_storage_account_name" {
  type = list(string)
  default = [ "pocsa67", "pocsa68" , "pocsa70" ]
  
}