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
module "compute" {
  source = "../../modules/azure/compute"

  resource_group_name  = data.azurerm_resource_group.main.name
  location             = data.azurerm_resource_group.main.location
  web_subnet_id        = module.network.web_subnet_id
  admin_ssh_public_key = var.admin_ssh_public_key

  tags = local.common_tags
}

moved {
  from = azurerm_public_ip.web
  to   = module.compute.azurerm_public_ip.web
}

moved {
  from = azurerm_network_interface.web
  to   = module.compute.azurerm_network_interface.web
}

moved {
  from = azurerm_linux_virtual_machine.web
  to   = module.compute.azurerm_linux_virtual_machine.web
}

module "monitoring" {
  source = "../../modules/azure/monitoring"

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  virtual_machine_id   = module.compute.virtual_machine_id
  virtual_machine_name = module.compute.virtual_machine_name

  tags = local.common_tags
}
