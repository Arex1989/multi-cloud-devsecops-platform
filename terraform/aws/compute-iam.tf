resource "aws_iam_role" "ec2" {
  name = "multicloud-devsecops-${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-ec2-role"
    Project     = "Multi-Cloud-DevSecOps-Platform"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_instance_profile" "ec2" {
  name = "multicloud-devsecops-${var.environment}-ec2-profile"
  role = aws_iam_role.ec2.name

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-ec2-profile"
    Project     = "Multi-Cloud-DevSecOps-Platform"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}