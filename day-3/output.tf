# output "ami_id" {
#   value = aws_instance.shiv_vpc_instance.id
# }

# output "availability_zone" {
#   value = aws_instance.shiv_vpc_instance.availability_zone
# }

# # output "instance_id" {
# #   value = aws_instance.shiv_vpc_instance.instance_id
# # }

# output "instance_type" {
#   value = aws_instance.shiv_vpc_instance.instance_type
# }

output "ami_ids" {
  description = "AMI IDs of all EC2 instances"
  value       = aws_instance.shiv_vpc_instance[*].ami
}

output "availability_zones" {
  description = "Availability Zones of all EC2 instances"
  value       = aws_instance.shiv_vpc_instance[*].availability_zone
}

output "instance_ids" {
  description = "IDs of all EC2 instances"
  value       = aws_instance.shiv_vpc_instance[*].id
}

output "instance_types" {
  description = "Instance types of all EC2 instances"
  value       = aws_instance.shiv_vpc_instance[*].instance_type
}

output "public_ips" {
  description = "Public IPs of all EC2 instances"
  value       = aws_instance.shiv_vpc_instance[*].public_ip
}

output "private_ips" {
  description = "Private IPs of all EC2 instances"
  value       = aws_instance.shiv_vpc_instance[*].private_ip
}

output "instance_names" {
  description = "Name tags of all EC2 instances"
  value       = aws_instance.shiv_vpc_instance[*].tags["Name"]
}