output "elb_sg_id" {
  value       = aws_security_group.elb_sg.id
  description = "The ID of the ELB security group"
}
