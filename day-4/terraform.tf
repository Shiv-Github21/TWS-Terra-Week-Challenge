terraform {

  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "west-demo-bucket-day3"
    key          = "day-3/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true # — no DynamoDB!
  }
}

provider "aws" {
  region = "us-west-2"
}

#form allows you to configure multiple instances of the same provider using aliases.
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

# Note: Use the version that you've actually tested with.
# If your Terraform installation is 1.13.x and AWS provider is 6.54.x, the above is ideal.