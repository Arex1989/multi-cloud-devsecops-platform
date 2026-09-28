variable "resource_group_name" {
  description = "Azure resource group containing the network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
}

variable "web_subnet_name" {
  description = "Web subnet name"
  type        = string
}

variable "web_subnet_prefixes" {
  description = "Web subnet address prefixes"
  type        = list(string)
}

variable "application_subnet_name" {
  description = "Application subnet name"
  type        = string
}

variable "application_subnet_prefixes" {
  description = "Application subnet address prefixes"
  type        = list(string)
}

variable "management_subnet_name" {
  description = "Management subnet name"
  type        = string
}

variable "management_subnet_prefixes" {
  description = "Management subnet address prefixes"
  type        = list(string)
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
