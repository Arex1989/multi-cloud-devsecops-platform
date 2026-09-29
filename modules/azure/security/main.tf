resource "azurerm_network_security_group" "web" {
  name                = var.web_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_group" "application" {
  name                = var.application_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Web-Tier-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = var.application_source_cidr
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "management" {
  name                = var.management_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_rule" "web_https" {
  name                        = "Allow-HTTPS-Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.web.name
}

resource "azurerm_network_security_rule" "web_ssh_admin" {
  name                        = "Allow-SSH-Admin"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.ssh_source_cidr
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.web.name
}

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = var.web_subnet_id
  network_security_group_id = azurerm_network_security_group.web.id
}

resource "azurerm_subnet_network_security_group_association" "application" {
  subnet_id                 = var.application_subnet_id
  network_security_group_id = azurerm_network_security_group.application.id
}

resource "azurerm_subnet_network_security_group_association" "management" {
  subnet_id                 = var.management_subnet_id
  network_security_group_id = azurerm_network_security_group.management.id
}
