output "resource_group_name" {
  description = "Existing Azure resource group used by the platform"
  value       = data.azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Location of the Azure resource group"
  value       = data.azurerm_resource_group.main.location
}

output "resource_group_id" {
  description = "Azure resource group ID"
  value       = data.azurerm_resource_group.main.id
}

output "azure_vnet_id" {
  description = "Azure virtual network ID"
  value       = azurerm_virtual_network.main.id
}

output "azure_vnet_address_space" {
  description = "Azure virtual network address space"
  value       = azurerm_virtual_network.main.address_space
}

output "azure_web_subnet_id" {
  description = "Azure web subnet ID"
  value       = azurerm_subnet.web.id
}

output "azure_application_subnet_id" {
  description = "Azure application subnet ID"
  value       = azurerm_subnet.application.id
}

output "azure_management_subnet_id" {
  description = "Azure management subnet ID"
  value       = azurerm_subnet.management.id
}
