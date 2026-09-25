# SNS topic used by CloudWatch alarms
resource "aws_sns_topic" "alerts" {
  name = "multicloud-devsecops-${var.environment}-alerts"

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-alerts"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Multi-Cloud-DevSecOps-Platform"
  }
}

# Optional email subscription.
# AWS will send a confirmation email before notifications become active.
resource "aws_sns_topic_subscription" "email" {
  count = var.alarm_email != "" ? 1 : 0

  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

# CloudWatch log group for the web tier
resource "aws_cloudwatch_log_group" "web" {
  name              = "/multicloud-devsecops/${var.environment}/web"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-web-logs"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Multi-Cloud-DevSecOps-Platform"
  }
}

# High CPU alarm for the existing EC2 web instance
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "multicloud-devsecops-${var.environment}-web-high-cpu"
  alarm_description   = "Triggers when EC2 CPU utilization exceeds the configured threshold"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_alarm_threshold
  treat_missing_data  = "notBreaching"

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-web-high-cpu"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Multi-Cloud-DevSecOps-Platform"
  }
}

# EC2 instance status-check alarm
resource "aws_cloudwatch_metric_alarm" "instance_status_check" {
  alarm_name          = "multicloud-devsecops-${var.environment}-web-status-check"
  alarm_description   = "Triggers when the EC2 instance fails an instance status check"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 1
  treat_missing_data  = "notBreaching"

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]

  tags = {
    Name        = "multicloud-devsecops-${var.environment}-web-status-check"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Multi-Cloud-DevSecOps-Platform"
  }
}