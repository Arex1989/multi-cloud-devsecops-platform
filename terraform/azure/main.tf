data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Cloud       = "Azure"
  }
}

module "network" {
  source = "../../modules/azure/network"

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  vnet_name          = "vnet-multicloud-dev"
  vnet_address_space = ["10.30.0.0/16"]

  web_subnet_name     = "snet-web"
  web_subnet_prefixes = ["10.30.1.0/24"]

  application_subnet_name     = "snet-app"
  application_subnet_prefixes = ["10.30.10.0/24"]

  management_subnet_name     = "snet-management"
  management_subnet_prefixes = ["10.30.20.0/24"]

  tags = local.common_tags
}

moved {
  from = azurerm_virtual_network.main
  to   = module.network.azurerm_virtual_network.main
}

moved {
  from = azurerm_subnet.web
  to   = module.network.azurerm_subnet.web
}

moved {
  from = azurerm_subnet.application
  to   = module.network.azurerm_subnet.application
}

moved {
  from = azurerm_subnet.management
  to   = module.network.azurerm_subnet.management
}