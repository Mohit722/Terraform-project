provider "aws" {
  region = "ap-south-1"
}

# Data for availability zones
data "aws_availability_zones" "available" {}

# Call the network module to create an ELB security group
module "network" {
  source                 = "../../modules/network"
  elb_sg_name            = "mohi-example-elb-sg"
  vpc_id                 = var.vpc_id                     # Reference the VPC ID variable
  elb_port               = var.elb_port
  allowed_inbound_cidrs  = ["0.0.0.0/0"]
}

# Call the ELB module to create the load balancer
module "elb" {
  source                      = "../../modules/elb"
  elb_name                    = "mohi-elb-example"
  elb_security_groups         = [module.network.elb_sg_id]
  elb_availability_zones      = data.aws_availability_zones.available.names
  elb_health_check_target     = "HTTP:${var.server_port}/"
  elb_health_check_interval    = 30
  elb_health_check_timeout      = 3
  elb_healthy_threshold        = 2
  elb_unhealthy_threshold      = 2
  elb_port                     = var.elb_port
  instance_port                = var.server_port
}

# Call the ASG module to create the launch configuration and auto-scaling group
module "asg" {
  source                     = "../../modules/asg"
  launch_config_name         = "mohi-example-launchconfig"
  custom_ami_id              = var.custom_ami_id
  instance_type              = var.instance_type
  instance_security_groups   = [module.network.elb_sg_id]
  user_data_script           = file("../../scripts/user-data.sh")  # Ensure the path to your user-data script is correct
  asg_name                   = "mohi-example-asg"
  asg_min_size               = 2
  asg_max_size               = 6
  subnet_ids                 = var.subnet_ids                 # Reference the Subnet IDs variable
  elb_name                   = module.elb.elb_name
  instance_name_tag          = "MOHI-ASG-Instance"
}

# Output the Load Balancer DNS name
output "clb_dns_name" {
  value       = module.elb.elb_dns_name
  description = "The domain name of the load balancer"
}
