output "web_security_group_id" {
  description = "ID of the public web security group"
  value       = aws_security_group.web.id
}

output "app_security_group_id" {
  description = "ID of the private application security group"
  value       = aws_security_group.app.id
}

output "vpc_endpoints_security_group_id" {
  description = "ID of the VPC endpoints security group"
  value       = aws_security_group.vpc_endpoints.id
}