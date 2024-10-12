resource "aws_elb" "this" {
  name                = var.elb_name
  security_groups     = var.elb_security_groups
  availability_zones  = var.elb_availability_zones

  health_check {
    target              = var.elb_health_check_target
    interval            = var.elb_health_check_interval
    timeout             = var.elb_health_check_timeout
    healthy_threshold   = var.elb_healthy_threshold
    unhealthy_threshold = var.elb_unhealthy_threshold
  }

  listener {
    lb_port           = var.elb_port
    lb_protocol       = "http"
    instance_port     = var.instance_port
    instance_protocol = "http"
  }
}
