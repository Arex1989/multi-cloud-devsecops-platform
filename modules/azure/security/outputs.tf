output "web_nsg_id" {
  description = "Web network security group ID"
  value       = azurerm_network_security_group.web.id
}

output "web_nsg_name" {
  description = "Web network security group name"
  value       = azurerm_network_security_group.web.name
}

output "application_nsg_id" {
  description = "Application network security group ID"
  value       = azurerm_network_security_group.application.id
}

output "application_nsg_name" {
  description = "Application network security group name"
  value       = azurerm_network_security_group.application.name
}

output "management_nsg_id" {
  description = "Management network security group ID"
  value       = azurerm_network_security_group.management.id
}

output "management_nsg_name" {
  description = "Management network security group name"
  value       = azurerm_network_security_group.management.name
}
