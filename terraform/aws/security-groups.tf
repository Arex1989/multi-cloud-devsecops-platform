moved {
  from = aws_security_group.web
  to   = module.security.aws_security_group.web
}

moved {
  from = aws_vpc_security_group_ingress_rule.web_http
  to   = module.security.aws_vpc_security_group_ingress_rule.web_http
}

moved {
  from = aws_vpc_security_group_ingress_rule.web_https
  to   = module.security.aws_vpc_security_group_ingress_rule.web_https
}

moved {
  from = aws_vpc_security_group_egress_rule.web_egress
  to   = module.security.aws_vpc_security_group_egress_rule.web_egress
}

moved {
  from = aws_vpc_security_group_egress_rule.web_s3
  to   = module.security.aws_vpc_security_group_egress_rule.web_s3
}

moved {
  from = aws_security_group.app
  to   = module.security.aws_security_group.app
}

moved {
  from = aws_vpc_security_group_ingress_rule.app_from_web
  to   = module.security.aws_vpc_security_group_ingress_rule.app_from_web
}

moved {
  from = aws_vpc_security_group_egress_rule.app_egress
  to   = module.security.aws_vpc_security_group_egress_rule.app_egress
}

moved {
  from = aws_security_group.vpc_endpoints
  to   = module.security.aws_security_group.vpc_endpoints
}

moved {
  from = aws_vpc_security_group_egress_rule.vpc_endpoints_egress
  to   = module.security.aws_vpc_security_group_egress_rule.vpc_endpoints_egress
}