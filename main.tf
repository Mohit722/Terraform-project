# configure our AWS connection

provider "aws" {
 region = "ap-south-1"
}

# GET The list of Availability zones in the current Region

data "aws_availability_zones" "all" {}

# Create A security group that controls what traffic an go In and Out of the ELB

resource "aws_security_group" "elb" {
  name = "mohi-example-elb"

  # Allow all outbound (-1)
  egress {
   from_port = 0
   to_port   = 0
   protocol  = "-1"
   cidr_blocks = ["0.0.0.0/0"]
}

  # Ibound HTTP from anywhere
  ingress {
      from_port  = var.elb_port
      to_port    = var.elb_port
      protocol   = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
 }
}


# Create an Application ELB to Route Traffic Across the Auto Scaling Group

resource "aws_elb" "example" {
  name                = "mohi-elb-example"
  security_groups     = [aws_security_group.elb.id]
  availability_zones  = data.aws_availability_zones.all.names
  
  health_check {
   target               = "HTTP:${var.server_port}/"
   interval             = 30
   timeout              = 3
   healthy_threshold    = 2 
   unhealthy_threshold  = 2 
}

# This adds a listener for incoming HTTP requests
  listener {
   lb_port           = var.elb_port
   lb_protocol       = "http"
   instance_port     = var.server_port
   instance_protocol = "http"
 }
}

# Create a Launch Configuration that defines each EC2 Instance in the ASG

resource "aws_launch_configuration" "example" {
  name = "mohi-example-launchconfig"
 
 # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type in ap-south-01
  image_id       = "ami-0ad21ae1d0696ad58"
  instance_type  = "t2.micro"
  security_groups = [aws_security_group.elb.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1 style="font-size:50px; color: blue;">WEZVA TECHNOLOGIES</h1></body></html>" > /var/www/html/index.html    
              nohup busybox httpd -f -p "${var.server_port}" &&
              EOF


  # Whenever using a launch configuration with an auto scaling group, you must see below
  lifecycle {
    create_before_destroy = true
 }
}


# Create an Auto Scaling Group

resource "aws_autoscaling_group" "example" {
  name                 = "mohi-example-asg"
  launch_configuration = aws_launch_configuration.example.id
  availability_zones   = data.aws_availability_zones.all.names

  min_size = 2
  max_size = 6

  load_balancers     = [aws_elb.example.name]
  health_check_type  = "ELB"

  tag {
   key                 = "Name"
   value               = "MOHI-ASG-PROJECT"
   propagate_at_launch = true
 }
}
