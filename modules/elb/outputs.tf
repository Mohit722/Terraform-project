output "elb_name" {
  value       = aws_elb.this.name
  description = "The name of the ELB"
}

output "elb_dns_name" {
  value       = aws_elb.this.dns_name
  description = "The DNS name of the ELB"
}
