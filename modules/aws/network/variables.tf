variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the AWS VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_app_subnet_cidr" {
  description = "CIDR block for the private application subnet"
  type        = string
}

variable "management_subnet_cidr" {
  description = "CIDR block for the management subnet"
  type        = string
}
