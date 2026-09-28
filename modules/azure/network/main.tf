resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = var.tags
}

resource "azurerm_subnet" "web" {
  name                 = var.web_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.web_subnet_prefixes
}

resource "azurerm_subnet" "application" {
  name                 = var.application_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.application_subnet_prefixes
}

resource "azurerm_subnet" "management" {
  name                 = var.management_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.management_subnet_prefixes
}
