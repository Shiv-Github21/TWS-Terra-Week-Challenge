terraform {

  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
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