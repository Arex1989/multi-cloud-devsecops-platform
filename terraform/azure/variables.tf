variable "location" {
  description = "Azure region for the multi-cloud platform"
  type        = string
  default     = "UK South"
}

variable "resource_group_name" {
  description = "Azure resource group used by the platform"
  type        = string
  default     = "rg-azure-enterprise-dev"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project identifier used for tagging"
  type        = string
  default     = "Multi-Cloud-DevSecOps-Platform"
}

variable "admin_ssh_public_key" {
  description = "SSH public key used for the Azure Linux VM administrator"
  type        = string
}
