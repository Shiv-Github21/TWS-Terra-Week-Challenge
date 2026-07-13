variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
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

variable "tags" {
  description = "Common resource tags"
  type        = map(string)

  default = {
    Environment = "dev"
    Owner       = "Shiv"
    Team        = "DevOps"
  }
}

variable "security_groups" {
  description = "Security group names"
  type        = set(string)

  default = [
    "web",
    "db",
    "web"
  ]
}

variable "server" {
  description = "Server configuration"

  type = object({
    name = string
    cpu  = number
    os   = string
  })

  default = {
    name = "web-server"
    cpu  = 2
    os   = "ubuntu"
  }
}

variable "environment" {
  description = "Deployment environment"

  type    = string
  default = "dev"

  validation {
    condition = contains(
      ["dev", "staging", "prod"],
      var.environment
    )

    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "db_password" {
  description = "Database password"

  type      = string
  sensitive = true
}