terraform {
backend "azurerm" {
resource_group_name   = "poc-resources"
storage_account_name  = "newpoctf"
container_name        = "tfstate"
key                   = "remote.terraform.tfstate"  //tf state file name
}
}
