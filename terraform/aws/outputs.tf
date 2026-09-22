output "vpc_id" {
  description = "ID of the AWS VPC"
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.network.public_subnet_id
}

output "private_app_subnet_id" {
  description = "ID of the private application subnet"
  value       = module.network.private_app_subnet_id
}

output "management_subnet_id" {
  description = "ID of the management subnet"
  value       = module.network.management_subnet_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.network.internet_gateway_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.network.public_route_table_id
}

output "aws_region" {
  description = "AWS region used for the deployment"
  value       = var.aws_region
}