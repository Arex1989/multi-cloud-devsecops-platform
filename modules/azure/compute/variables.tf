variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "web_subnet_id" {
  description = "Azure web subnet ID"
  type        = string
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the Azure Linux VM administrator"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
