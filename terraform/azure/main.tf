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
