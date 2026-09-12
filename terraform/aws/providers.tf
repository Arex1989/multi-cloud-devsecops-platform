provider "aws" {
  region  = var.aws_region

  default_tags {
    tags = {
      Project     = "Multi-Cloud-DevSecOps-Platform"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}