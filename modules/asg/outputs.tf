output "asg_name" {
  value       = aws_autoscaling_group.this.name
  description = "The name of the auto scaling group"
}

output "launch_configuration_name" {
  value       = aws_launch_configuration.this.name
  description = "The name of the launch configuration"
}
