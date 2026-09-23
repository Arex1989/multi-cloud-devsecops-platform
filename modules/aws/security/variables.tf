variable "vpc_id" {
  description = "VPC ID used by the security groups"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC used to restrict security group traffic"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}