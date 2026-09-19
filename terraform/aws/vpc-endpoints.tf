resource "aws_security_group" "vpc_endpoints" {
  name        = "multicloud-devsecops-${var.environment}-endpoint-sg"
  description = "Security group for private VPC interface endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    description = "Allow endpoint response traffic within VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-endpoint-sg"
    Project     = "Multi-Cloud-DevSecOps-Platform"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "management"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public.id
  ]

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-s3-endpoint"
    Project     = "Multi-Cloud-DevSecOps-Platform"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.management.id]
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-ssm-endpoint"
    Project     = "Multi-Cloud-DevSecOps-Platform"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "management"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.management.id]
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-ssmmessages-endpoint"
    Project     = "Multi-Cloud-DevSecOps-Platform"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "management"
  }
}
resource "aws_vpc_security_group_egress_rule" "web_s3" {
  security_group_id = aws_security_group.web.id

  description = "Allow HTTPS access to Amazon S3 through VPC endpoint"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  prefix_list_id = aws_vpc_endpoint.s3.prefix_list_id
}