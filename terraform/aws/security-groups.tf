resource "aws_security_group" "web" {
  name        = "multicloud-devsecops-${var.environment}-web-sg"
  description = "Security group for the public web tier"
  vpc_id      = module.network.vpc_id

  tags = {
    Name = "multicloud-devsecops-${var.environment}-web-sg"
    Tier = "web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "web_https" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS inbound traffic"
}

resource "aws_vpc_security_group_egress_rule" "web_egress" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow outbound traffic"
}

resource "aws_vpc_security_group_egress_rule" "web_s3" {
  security_group_id = aws_security_group.web.id
  prefix_list_id    = "pl-6ea54007"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS access to Amazon S3 through VPC endpoint"
}

resource "aws_security_group" "app" {
  name        = "multicloud-devsecops-${var.environment}-app-sg"
  description = "Security group for the private application tier"
  vpc_id      = module.network.vpc_id

  tags = {
    Name = "multicloud-devsecops-${var.environment}-app-sg"
    Tier = "private-app"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_web" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.web.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
  description                  = "Allow application traffic from web tier"
}

resource "aws_vpc_security_group_egress_rule" "app_egress" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow outbound traffic"
}

resource "aws_security_group" "vpc_endpoints" {
  name        = "multicloud-devsecops-${var.environment}-endpoint-sg"
  description = "Security group for private VPC interface endpoints"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "Allow HTTPS from the VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.20.0.0/16"]
  }

  tags = {
    Name = "multicloud-devsecops-${var.environment}-endpoint-sg"
    Tier = "management"
  }
}

resource "aws_vpc_security_group_egress_rule" "vpc_endpoints_egress" {
  security_group_id = aws_security_group.vpc_endpoints.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow outbound traffic"
}