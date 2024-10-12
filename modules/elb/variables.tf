variable "elb_name" {
  description = "Name of the ELB"
  type        = string
}

variable "elb_security_groups" {
  description = "Security groups associated with the ELB"
  type        = list(string)
}

variable "elb_availability_zones" {
  description = "Availability zones for the ELB"
  type        = list(string)
}

variable "elb_health_check_target" {
  description = "Target for ELB health check"
  type        = string
}

variable "elb_health_check_interval" {
  description = "Interval for ELB health check"
  type        = number
}

variable "elb_health_check_timeout" {
  description = "Timeout for ELB health check"
  type        = number
}

variable "elb_healthy_threshold" {
  description = "Healthy threshold for ELB"
  type        = number
}

variable "elb_unhealthy_threshold" {
  description = "Unhealthy threshold for ELB"
  type        = number
}

variable "elb_port" {
  description = "Port on which the ELB listens"
  type        = number
}

variable "instance_port" {
  description = "Port on the instance to route traffic to"
  type        = number
}
