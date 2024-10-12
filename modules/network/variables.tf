variable "elb_sg_name" {
  description = "Name prefix for the ELB security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ELB security group will be created"
  type        = string
}

variable "elb_port" {
  description = "ELB port for HTTP traffic"
  type        = number
}

variable "allowed_inbound_cidrs" {
  description = "CIDR blocks allowed for inbound traffic"
  type        = list(string)
}
