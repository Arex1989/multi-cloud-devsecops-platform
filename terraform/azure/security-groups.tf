module "security" {
  source = "../../modules/azure/security"

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  web_nsg_name         = "nsg-multicloud-dev-web"
  application_nsg_name = "nsg-multicloud-dev-app"
  management_nsg_name  = "nsg-multicloud-dev-management"

  web_subnet_id         = module.network.web_subnet_id
  application_subnet_id = module.network.application_subnet_id
  management_subnet_id  = module.network.management_subnet_id

  ssh_source_cidr         = "61.8.130.111/32"
  application_source_cidr = "10.30.1.0/24"

  tags = local.common_tags
}

moved {
  from = azurerm_network_security_group.web
  to   = module.security.azurerm_network_security_group.web
}

moved {
  from = azurerm_network_security_group.application
  to   = module.security.azurerm_network_security_group.application
}

moved {
  from = azurerm_network_security_group.management
  to   = module.security.azurerm_network_security_group.management
}

moved {
  from = azurerm_network_security_rule.web_https
  to   = module.security.azurerm_network_security_rule.web_https
}

moved {
  from = azurerm_network_security_rule.web_ssh_admin
  to   = module.security.azurerm_network_security_rule.web_ssh_admin
}

moved {
  from = azurerm_subnet_network_security_group_association.web
  to   = module.security.azurerm_subnet_network_security_group_association.web
}

moved {
  from = azurerm_subnet_network_security_group_association.application
  to   = module.security.azurerm_subnet_network_security_group_association.application
}

moved {
  from = azurerm_subnet_network_security_group_association.management
  to   = module.security.azurerm_subnet_network_security_group_association.management
}
