resource "aws_instance" "web" {
  # Keep the existing AMI so Terraform does not replace the working EC2
  ami           = "ami-056629e8f780a5e50"
  instance_type = "t4g.micro"

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  associate_public_ip_address = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 10
  }

  user_data = <<-EOF
    #!/bin/bash
    set -eux

    dnf update -y
    dnf install -y nginx

    systemctl enable nginx
    systemctl start nginx

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Multi-Cloud DevSecOps Platform</title>
    </head>
    <body>
      <h1>Multi-Cloud DevSecOps Platform</h1>
      <p>AWS web tier - Terraform managed</p>
    </body>
    </html>
    HTML
  EOF

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-web"
    Project     = "Multi-Cloud-DevSecOps-Platform"
    Environment = var.environment
    Tier        = "web"
    ManagedBy   = "Terraform"
  }
}