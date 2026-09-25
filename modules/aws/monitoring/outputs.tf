output "sns_topic_arn" {
  description = "ARN of the SNS topic used for CloudWatch alerts"
  value       = aws_sns_topic.alerts.arn
}

output "log_group_name" {
  description = "Name of the CloudWatch log group for the web tier"
  value       = aws_cloudwatch_log_group.web.name
}

output "high_cpu_alarm_name" {
  description = "Name of the high CPU CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "instance_status_check_alarm_name" {
  description = "Name of the EC2 instance status-check CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.instance_status_check.alarm_name
}