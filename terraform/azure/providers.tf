terraform {
  backend "azurerm" {
    resource_group_name  = "rg-azure-enterprise-dev"
    storage_account_name = "tfstate2f877566"
    container_name       = "tfstate"
    key                  = "azure-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}
