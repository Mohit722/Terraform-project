# Terraform Modules:
---------------------

This directory contains reusable Terraform modules designed to simplify the infrastructure provisioning process. Each module encapsulates a specific functionality or resource configuration, allowing for better organization, reusability, and maintainability of Terraform code.

 
Overview: Terraform modules allow you to create infrastructure as code (IaC) that can be easily reused across different projects or environments. By using modules, you can keep your Terraform configurations DRY (Don't Repeat Yourself) and maintain a consistent infrastructure setup.


# Module Structure
-------------------

Each module in this directory has the following structure:


modules/
├── network/
│   ├── main.tf         # Contains resource definitions for the network setup
│   ├── variables.tf    # Defines input variables for the network module
│   └── outputs.tf      # Specifies outputs from the network module
├── elb/
│   ├── main.tf         # Contains resource definitions for the Elastic Load Balancer
│   ├── variables.tf    # Defines input variables for the ELB module
│   └── outputs.tf      # Specifies outputs from the ELB module
└── asg/
    ├── main.tf         # Contains resource definitions for the Auto Scaling Group
    ├── variables.tf    # Defines input variables for the ASG module
    └── outputs.tf      # Specifies outputs from the ASG module




# Module Details

1. Network Module:
—-----------------

- Purpose: Creates networking resources such as security groups for the Elastic Load Balancer (ELB).
- Usage:
  - Inputs:
    - `elb_sg_name`: Name of the security group for the ELB.
    - `vpc_id`: ID of the VPC where the security group will be created.
    - `allowed_inbound_cidrs`: List of CIDR blocks that can access the ELB.
  - Outputs:
    - `elb_sg_id`: The ID of the security group created.
  

- Example:
 
  module "network" {
    source                 = "../../modules/network"
    elb_sg_name            = "my-elb-sg"
    vpc_id                 = var.vpc_id
    allowed_inbound_cidrs  = ["0.0.0.0/0"]
  }
 


2. ELB Module:
—-------------

- Purpose: Provisions an Elastic Load Balancer (ELB) to distribute incoming traffic across multiple instances.
- Usage:
  - Inputs:
    - `elb_name`: Name of the ELB.
    - `elb_security_groups`: Security groups attached to the ELB.
    - `elb_availability_zones`: Availability zones where the ELB will be deployed.
    - `elb_health_check_target`: Health check configuration for the ELB.
    - `elb_port`: Port for the ELB to listen on.
    - `instance_port`: Port on the instances to route traffic to.
  - Outputs:
    - `elb_dns_name`: The DNS name of the ELB.
  
- Example:
 
  module "elb" {
    source                      = "../../modules/elb"
    elb_name                    = "my-elb"
    elb_security_groups         = [module.network.elb_sg_id]
    elb_availability_zones      = data.aws_availability_zones.available.names
    elb_health_check_target     = "HTTP:80/"
    elb_port                    = 80
    instance_port               = 8080
  }
  


# 3. Auto Scaling Group (ASG) Module:
—------------------------------------

- Purpose: Creates an Auto Scaling Group to manage the scaling of EC2 instances based on demand.
- Usage:
  - Inputs:
    - `launch_config_name`: Name for the launch configuration.
    - `custom_ami_id`: AMI ID for the EC2 instances.
    - `instance_type`: Type of EC2 instance to launch.
    - `instance_security_groups`: Security groups associated with the instances.
    - `user_data_script`: User data script to configure instances on launch.
    - `asg_name`: Name for the Auto Scaling Group.
    - `asg_min_size`: Minimum size of the Auto Scaling Group.
    - `asg_max_size`: Maximum size of the Auto Scaling Group.
    - `subnet_ids`: List of subnet IDs where the instances will be deployed.
    - `elb_name`: Name of the associated ELB.
    - `instance_name_tag`: Tag for the EC2 instances.
  - Outputs:
    - `asg_id`: The ID of the Auto Scaling Group created.
  
- Example:

  module "asg" {
    source                     = "../../modules/asg"
    launch_config_name         = "my-launch-config"
    custom_ami_id              = var.custom_ami_id
    instance_type              = var.instance_type
    instance_security_groups   = [module.network.elb_sg_id]
    user_data_script           = file("../../scripts/user-data.sh")
    asg_name                   = "my-asg"
    asg_min_size               = 2
    asg_max_size               = 6
    subnet_ids                 = var.subnet_ids
    elb_name                   = module.elb.elb_name
    instance_name_tag          = "MyAppInstance"
  }
 




# Best Practices:
—----------------

- Reuse Modules: Reuse these modules across different environments (dev, staging, production) to maintain a consistent infrastructure setup.
- Version Control: Utilize version control to track changes in module configurations for easier rollbacks and collaboration.
- Document Changes: Keep this README updated with any modifications to module inputs, outputs, or functionality to maintain accurate documentation.


# Running Terraform:
—-------------------

To execute the Terraform code using these modules, follow these steps:

1. Navigate to your environment directory (e.g., `dev`, `staging`, `prod`):
   ```bash
   cd environments/dev
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Plan the changes:
   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```

4. Apply the changes:
   ```bash
   terraform apply -auto-approve
   ```




# Contributing
--------------
If you would like to contribute to this project, please submit a pull request or open an issue for discussion. Your contributions help improve the modules and make them more useful for everyone.


