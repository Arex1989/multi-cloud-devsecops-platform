module "security" {
  source = "../../modules/aws/security"

  vpc_id      = module.network.vpc_id
  vpc_cidr    = "10.20.0.0/16"
  environment = var.environment
}

module "network" {
  source = "../../modules/aws/network"

  environment             = var.environment
  vpc_cidr                = "10.20.0.0/16"
  public_subnet_cidr      = var.public_subnet_cidr
  private_app_subnet_cidr = var.private_app_subnet_cidr
  management_subnet_cidr  = var.management_subnet_cidr
}

module "monitoring" {
  source = "../../modules/aws/monitoring"

  environment = var.environment
  instance_id = aws_instance.web.id

  # Leave empty for now unless you want CloudWatch to send
  # alarm notifications to an email address.
  alarm_email = ""

  cpu_alarm_threshold = 80
  log_retention_days  = 14
}

moved {
  from = aws_vpc.main
  to   = module.network.aws_vpc.main
}

moved {
  from = aws_subnet.public
  to   = module.network.aws_subnet.public
}

moved {
  from = aws_subnet.private_app
  to   = module.network.aws_subnet.private_app
}

moved {
  from = aws_subnet.management
  to   = module.network.aws_subnet.management
}

moved {
  from = aws_internet_gateway.main
  to   = module.network.aws_internet_gateway.main
}

moved {
  from = aws_route_table.public
  to   = module.network.aws_route_table.public
}

moved {
  from = aws_route.public_internet
  to   = module.network.aws_route.public_internet
}

moved {
  from = aws_route_table_association.public
  to   = module.network.aws_route_table_association.public
}