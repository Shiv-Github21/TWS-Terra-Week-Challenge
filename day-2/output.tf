output "my_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.shiv_aws_instance.id
}

output "availability_zone" {
  description = "Availability Zone of the EC2 instance"
  value       = aws_instance.shiv_aws_instance.availability_zone
}

output "instance_public_ip" {
  description = "Public IP Address"
  value       = aws_instance.shiv_aws_instance.public_ip
}

output "instance_public_dns" {
  description = "Public DNS Name"
  value       = aws_instance.shiv_aws_instance.public_dns
}

output "instance_private_ip" {
  description = "Private IP Address"
  value       = aws_instance.shiv_aws_instance.private_ip
}

output "instance_name" {
  description = "EC2 Name Tag"
  value       = aws_instance.shiv_aws_instance.tags["Name"]
}

output "instance_environment" {
  description = "Environment Tag"
  value       = aws_instance.shiv_aws_instance.tags["Environment"]
}

output "instance_type" {
  description = "EC2 Instance Type"
  value       = aws_instance.shiv_aws_instance.instance_type
}