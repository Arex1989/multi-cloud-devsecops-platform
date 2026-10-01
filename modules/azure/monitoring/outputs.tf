output "log_analytics_workspace_id" {
  description = "Resource ID of the Azure Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Azure Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_workspace_id" {
  description = "Workspace ID of the Azure Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main.workspace_id
}
