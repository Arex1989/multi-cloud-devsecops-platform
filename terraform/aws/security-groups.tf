resource "aws_security_group" "web" {
  name        = "multicloud-devsecops-${var.environment}-web-sg"
  description = "Security group for the public web tier"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "multicloud-devsecops-${var.environment}-web-sg"
    Tier = "web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.web.id
  description       = "Allow HTTP traffic from the Internet"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "web_https" {
  security_group_id = aws_security_group.web.id
  description       = "Allow HTTPS traffic from the Internet"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "web_egress" {
  security_group_id = aws_security_group.web.id
  description       = "Allow outbound traffic within the VPC"

  cidr_ipv4   = aws_vpc.main.cidr_block
  ip_protocol = "-1"
}

resource "aws_security_group" "app" {
  name        = "multicloud-devsecops-${var.environment}-app-sg"
  description = "Security group for the private application tier"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "multicloud-devsecops-${var.environment}-app-sg"
    Tier = "application"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_web" {
  security_group_id            = aws_security_group.app.id
  description                  = "Allow application traffic from web tier"
  referenced_security_group_id = aws_security_group.web.id

  from_port   = 8080
  ip_protocol = "tcp"
  to_port     = 8080
}

resource "aws_vpc_security_group_egress_rule" "app_egress" {
  security_group_id = aws_security_group.app.id
  description       = "Allow outbound traffic within the VPC"

  cidr_ipv4   = aws_vpc.main.cidr_block
  ip_protocol = "-1"
}