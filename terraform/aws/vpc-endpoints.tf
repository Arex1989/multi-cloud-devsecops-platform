resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.network.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    module.network.public_route_table_id
  ]

  tags = {
    Name = "multicloud-devsecops-${var.environment}-s3-endpoint"
    Tier = "management"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = module.network.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.network.management_subnet_id]
  security_group_ids  = [module.security.vpc_endpoints_security_group_id]
  private_dns_enabled = true

  tags = {
    Name = "multicloud-devsecops-${var.environment}-ssm-endpoint"
    Tier = "management"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = module.network.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.network.management_subnet_id]
  security_group_ids  = [module.security.vpc_endpoints_security_group_id]
  private_dns_enabled = true

  tags = {
    Name = "multicloud-devsecops-${var.environment}-ssmmessages-endpoint"
    Tier = "management"
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id            = module.network.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type = "Interface"

  subnet_ids         = [module.network.management_subnet_id]
  security_group_ids = [module.security.vpc_endpoints_security_group_id]

  private_dns_enabled = true

  tags = {
    Name = "multicloud-devsecops-${var.environment}-logs-endpoint"
    Tier = "management"
  }
}