terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.8.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {} # This is required
  subscription_id = "c8c0574f-6d3f-4c1a-8d5d-de15c56203be"
}
