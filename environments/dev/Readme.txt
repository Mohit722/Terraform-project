# README Content

# Terraform Configuration Overview

This Terraform configuration is designed to provision an Elastic Load Balancer (ELB) and an Auto Scaling Group (ASG) on AWS, leveraging a custom AMI for the EC2 instances. The configuration is structured to enable modularity and reusability across different environments.

# Directory Structure

```
environments/
└── dev/
    ├── main.tf
    ├── variables.tf
    └── terraform.tfvars
```

# 1. `main.tf`

This file serves as the primary configuration file where the resources and their relationships are defined. 

# Key Components:

- Provider Configuration: Specifies the AWS region where resources will be created.

    ```hcl
    provider "aws" {
      region = "ap-south-1"
    }
    ```

- Data Sources: Retrieves data about the available availability zones in the specified region, which can be used for resource placement.

    ```hcl
    data "aws_availability_zones" "available" {}
    ```

- Module Calls: The configuration uses modules to create a structured and reusable codebase. It includes calls to modules for networking, ELB, and ASG.

    ```hcl
    module "network" {
      ...
    }

    module "elb" {
      ...
    }

    module "asg" {
      ...
    }
    ```

- Load Balancer and Auto Scaling Group: The ELB routes traffic to instances in the ASG, which scales based on demand.

This structured approach improves clarity and facilitates changes, allowing different teams or environments to leverage the same infrastructure code.


# 2. `variables.tf`

This file defines all the variables that can be customized when deploying the infrastructure. Each variable has a description, type, and default value (if applicable).

# Key Variables:

- `instance_type`: Defines the type of EC2 instances in the ASG.

    ```hcl
    variable "instance_type" {
      description = "The instance type for the EC2 instances in the ASG"
      type        = string
    }
    ```

- `custom_ami_id`: Specifies the AMI ID to use for the EC2 instances.

    ```hcl
    variable "custom_ami_id" {
      description = "The AMI ID for the EC2 instances"
      type        = string
    }
    ```

- `elb_port` and `server_port`: Define the ports used by the ELB and the server, respectively.

- `vpc_id` and `subnet_ids`: Specify the VPC and subnets where resources will be deployed, making it easier to manage network configurations.

This separation of variable definitions from resource configurations allows users to easily adjust parameters without modifying the main configuration.



# 3. `terraform.tfvars`

This file is used to provide actual values for the variables defined in `variables.tf`. It simplifies the customization process for different environments by allowing you to change values as needed.

#### Example Content:

```hcl
instance_type = "t2.micro"
custom_ami_id = "ami-0ad21ae1d0696ad58"

elb_port = 80
server_port = 8080

vpc_id = "vpc-xxxxxxxx"
subnet_ids = ["subnet-xxxxxxx", "subnet-yyyyyyy"]
```


# Explanation of Values:

- `instance_type`: Set to "t2.micro" for cost-effective resource usage. This can be changed based on performance requirements.

- `custom_ami_id`: Replace with the actual AMI ID used for launching EC2 instances, ensuring the instances have the necessary software and configuration.

- `elb_port` and `server_port`: The ELB listens on port 80 and the server on port 8080, suitable for standard web applications.

- `vpc_id`: The ID of the VPC where resources are provisioned. Replace with the actual VPC ID.

- `subnet_ids`: A list of subnet IDs where the ASG instances will be deployed. This allows for better control over resource placement and availability.


# Conclusion

This Terraform configuration provides a robust framework for deploying a scalable web application architecture on AWS. By leveraging modular design and clear variable definitions, it simplifies infrastructure management and enables easier collaboration among team members.




Here’s a concise and clear way to document the full command sequence for running Terraform inside the `dev` environment. 

# Terraform Commands for Dev Environment

When working within the `dev` environment, navigate to the directory and run the following commands:

1. Navigate to the Dev Environment:
   ```bash
   cd environments/dev
   ```

2. Initialize Terraform:
   This command downloads the necessary provider plugins and sets up the backend.
   ```bash
   terraform init
   ```

3. Review the Changes:
   This command generates an execution plan, showing what actions Terraform will take.
   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```

4. Apply the Configuration:
   This command applies the changes required to reach the desired state of the configuration.
   ```bash
   terraform apply -var-file="terraform.tfvars" -auto-approve
   ```


# Simplified Command Usage

You can also run the commands without specifying the `-var-file` option if you are using the default `terraform.tfvars` file, as Terraform automatically loads it. Here’s how you can do it:

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

