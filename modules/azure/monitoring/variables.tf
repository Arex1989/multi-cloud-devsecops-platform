variable "resource_group_name" {
  description = "Azure resource group containing the monitored workload"
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources"
  type        = string
}

variable "virtual_machine_id" {
  description = "Resource ID of the Azure Linux virtual machine"
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the Azure Linux virtual machine"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
