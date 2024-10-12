# environments/dev/terraform.tfvars

vpc_id     = "vpc-xxxxxxxx"  # Replace with your actual VPC ID
subnet_ids = ["subnet-xxxxxxx", "subnet-yyyyyyy"]  # Replace with your actual Subnet IDs

server_port = 8080  # Optionally override the default
elb_port    = 80    # Optionally override the default

custom_ami_id  = "ami-0ad21ae1d0696ad58"  # Replace with your custom AMI ID if you have one
instance_type  = "t2.micro"  # Optionally override the default instance type
