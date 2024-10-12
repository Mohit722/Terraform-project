resource "aws_security_group" "elb_sg" {
  name_prefix = var.elb_sg_name
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.elb_port
    to_port     = var.elb_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_inbound_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
