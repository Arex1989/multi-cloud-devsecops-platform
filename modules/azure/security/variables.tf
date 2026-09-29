variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "location" {
  description = "Azure resource location"
  type        = string
}

variable "web_nsg_name" {
  description = "Web subnet network security group name"
  type        = string
}

variable "application_nsg_name" {
  description = "Application subnet network security group name"
  type        = string
}

variable "management_nsg_name" {
  description = "Management subnet network security group name"
  type        = string
}

variable "web_subnet_id" {
  description = "Azure web subnet ID"
  type        = string
}

variable "application_subnet_id" {
  description = "Azure application subnet ID"
  type        = string
}

variable "management_subnet_id" {
  description = "Azure management subnet ID"
  type        = string
}

variable "ssh_source_cidr" {
  description = "Administrative SSH source CIDR"
  type        = string
}

variable "application_source_cidr" {
  description = "Application tier source CIDR"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
