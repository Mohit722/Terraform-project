resource "aws_launch_configuration" "this" {
  name_prefix     = var.launch_config_name
  image_id        = var.custom_ami_id
  instance_type   = var.instance_type
  security_groups = var.instance_security_groups

  user_data = var.user_data_script

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.this.id
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  vpc_zone_identifier  = var.subnet_ids
  load_balancers       = [var.elb_name]

  tag {
    key                 = "Name"
    value               = var.instance_name_tag
    propagate_at_launch = true
  }
}
