output "vpc_id" {
  description = "ID of the AWS VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_app_subnet_id" {
  description = "ID of the private application subnet"
  value       = aws_subnet.private_app.id
}

output "management_subnet_id" {
  description = "ID of the management subnet"
  value       = aws_subnet.management.id
}

output "aws_region" {
  description = "AWS region used for the deployment"
  value       = var.aws_region
}