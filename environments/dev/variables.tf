# environments/dev/variables.tf

variable "instance_type" {
  description = "The instance type for the EC2 instances in the ASG"
  type        = string
}

variable "custom_ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "elb_port" {
  description = "The port for the ELB to listen on"
  type        = number
}

variable "server_port" {
  description = "The port the server listens on"
  type        = number
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}
