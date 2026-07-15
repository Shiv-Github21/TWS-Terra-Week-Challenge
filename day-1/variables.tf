variable "aws_instance_type" {
  description = "Type of AWS instance"
  type        = string
  default     = "t3.micro"
}
variable "aws_availability_zone" {
  description = "Availability zone for the instance"
  type        = string
  default     = "us-west-2a"
}