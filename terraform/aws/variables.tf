variable "aws_region" {
  description = "AWS region used to deploy the infrastructure"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.20.1.0/24"
}

variable "private_app_subnet_cidr" {
  description = "CIDR block for the private application subnet"
  type        = string
  default     = "10.20.10.0/24"
}

variable "management_subnet_cidr" {
  description = "CIDR block for the management subnet"
  type        = string
  default     = "10.20.20.0/24"
}