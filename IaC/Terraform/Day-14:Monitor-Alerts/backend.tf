terraform {
  backend "azurerm" {
    resource_group_name  = "infra-poc"
    storage_account_name = "poctf1"
    container_name       = "tfstate"
    key                  = "remote.terraform.tfstate" //tf state file name
  }
}
