resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    Name      = "github-actions-oidc"
    Project   = "Multi-Cloud-DevSecOps-Platform"
    ManagedBy = "Terraform"
  }
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:Arex1989@294122861/multi-cloud-devsecops-platform@1367647618:ref:refs/heads/main"
      ]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-terraform-role"

  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = {
    Name      = "github-actions-terraform-role"
    Project   = "Multi-Cloud-DevSecOps-Platform"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy" "github_actions_read_infrastructure" {
  name = "github-actions-read-infrastructure"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcAttributes",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeSubnets",
          "ec2:DescribeRouteTables",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribePrefixLists",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeTags",
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeVolumes",
          "ec2:DescribeInstanceCreditSpecifications",

          "iam:GetOpenIDConnectProvider",
          "iam:GetRole",
          "iam:GetInstanceProfile",
          "iam:ListRoles",
          "iam:GetRolePolicy",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "sns:GetTopicAttributes",
          "logs:DescribeLogGroups",
          "sns:ListTagsForResource",
          "logs:ListTagsForResource",
          "kms:DescribeKey",
          "kms:GetKeyPolicy",
          "kms:GetKeyRotationStatus",
          "kms:ListResourceTags",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:ListTagsForResource",
        ]

        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy" "github_actions_terraform_state" {
  name = "github-actions-terraform-state"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = "arn:aws:s3:::multi-cloud-devsecops-tfstate-149600119261-euc1"

        Condition = {
          StringEquals = {
            "s3:prefix" = "terraform/aws/terraform.tfstate"
          }
        }
      },
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = "arn:aws:s3:::multi-cloud-devsecops-tfstate-149600119261-euc1/terraform/aws/terraform.tfstate"
      },
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = "arn:aws:s3:::multi-cloud-devsecops-tfstate-149600119261-euc1/terraform/aws/terraform.tfstate.tflock"
      }
    ]
  })
}