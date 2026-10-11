terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-ntms-kv"
    storage_account_name = "terraformstatesamirstg"
    container_name = "samir"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "1ccfe38b-d78a-42b5-a870-2d835c22f9d0"
}