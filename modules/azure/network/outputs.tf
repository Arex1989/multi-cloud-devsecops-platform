output "vnet_id" {
  description = "Azure virtual network ID"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Azure virtual network name"
  value       = azurerm_virtual_network.main.name
}

output "vnet_address_space" {
  description = "Azure virtual network address space"
  value       = azurerm_virtual_network.main.address_space
}

output "web_subnet_id" {
  description = "Web subnet ID"
  value       = azurerm_subnet.web.id
}

output "application_subnet_id" {
  description = "Application subnet ID"
  value       = azurerm_subnet.application.id
}

output "management_subnet_id" {
  description = "Management subnet ID"
  value       = azurerm_subnet.management.id
}
