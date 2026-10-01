# Azure Monitoring, Logging and Observability Module

resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-multicloud-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "PerGB2018"
  retention_in_days = 30

  tags = var.tags
}

# Azure Monitor Agent
resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true

  tags = var.tags
}

# Data Collection Rule
resource "azurerm_monitor_data_collection_rule" "main" {
  name                = "dcr-multicloud-dev"
  resource_group_name = var.resource_group_name
  location            = var.location

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.main.id
      name                  = "log-analytics"
    }
  }

  data_flow {
    streams      = ["Microsoft-Perf"]
    destinations = ["log-analytics"]
  }

  data_sources {
    performance_counter {
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["\\Processor(*)\\% Processor Time"]
      name                          = "cpu-performance"
    }

    performance_counter {
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["\\Memory\\% Available Memory"]
      name                          = "memory-performance"
    }

    performance_counter {
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["\\Logical Disk(*)\\% Free Space"]
      name                          = "disk-performance"
    }
  }
  tags = var.tags
}

# Associate the DCR with the Azure Linux VM
resource "azurerm_monitor_data_collection_rule_association" "vm" {
  name                    = "dcra-multicloud-dev-web"
  target_resource_id      = var.virtual_machine_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.main.id
}

