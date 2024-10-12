variable "launch_config_name" {
  description = "Name prefix for the launch configuration"
  type        = string
}

variable "custom_ami_id" {
  description = "Custom AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_security_groups" {
  description = "Security groups for the instances"
  type        = list(string)
}

variable "user_data_script" {
  description = "User data script for instances"
  type        = string
}

variable "asg_name" {
  description = "Name for the auto scaling group"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum size of the auto scaling group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum size of the auto scaling group"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "elb_name" {
  description = "The name of the ELB to attach to"
  type        = string
}

variable "instance_name_tag" {
  description = "Name tag for the instances"
  type        = string
}
