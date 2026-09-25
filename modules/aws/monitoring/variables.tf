variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "instance_id" {
  description = "EC2 instance ID to monitor"
  type        = string
}

variable "alarm_email" {
  description = "Email address used for CloudWatch alarm notifications"
  type        = string
  default     = ""
}

variable "cpu_alarm_threshold" {
  description = "CPU utilization percentage that triggers the high CPU alarm"
  type        = number
  default     = 80
}

variable "log_retention_days" {
  description = "Number of days CloudWatch logs are retained"
  type        = number
  default     = 14
}