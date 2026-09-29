output "public_ip_id" {
  description = "Azure web public IP resource ID"
  value       = azurerm_public_ip.web.id
}

output "public_ip_address" {
  description = "Azure web public IP address"
  value       = azurerm_public_ip.web.ip_address
}

output "network_interface_id" {
  description = "Azure web network interface ID"
  value       = azurerm_network_interface.web.id
}

output "virtual_machine_id" {
  description = "Azure Linux virtual machine ID"
  value       = azurerm_linux_virtual_machine.web.id
}

output "virtual_machine_name" {
  description = "Azure Linux virtual machine name"
  value       = azurerm_linux_virtual_machine.web.name
}
