variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "my-aws-instance-type"
}
variable "availability_zones" {
  description = "AWS Availability Zones"
  type        = list(string)

  default = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c"
  ]
}