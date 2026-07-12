# Terraform Week Challenge 🚀
## Day 1 - Task 3

# Set Up Terraform on Your Local Machine and Create Your First Terraform Configuration

## Objective

The objective of this task was to set up Terraform on my local machine, configure the AWS provider, and create my first cloud resource using Terraform.

---

## Prerequisites

Before starting this task, I completed the following setup:

- Installed Terraform on my local machine.
- Configured AWS credentials using the AWS CLI (`aws configure`).
- Verified that Terraform was installed successfully.

---

## Terraform Configuration

I divided my Terraform configuration into two files.

### `terraform.tf`

This file contains the Terraform and AWS provider configuration.

```hcl
terraform {
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
```

### `main.tf`

This file contains the resource definition.

```hcl
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "shivendra-demo-s3-bucket-03"
}
```

---

## Step 1: Initialize Terraform

Initialized the Terraform working directory.

```bash
terraform init
```

**Output**

```text
Terraform has been successfully initialized!
```

This command downloaded the required AWS provider plugins and prepared the project for use.

---

## Step 2: Validate the Configuration

Validated the Terraform configuration.

```bash
terraform validate
```

**Output**

```text
Success! The configuration is valid.
```

This confirmed that the configuration had no syntax errors.

---

## Step 3: Preview the Infrastructure Changes

Generated an execution plan.

```bash
terraform plan
```

Terraform displayed the execution plan showing:

- **1 resource to be created**
- **0 resources to change**
- **0 resources to destroy**

The resource to be created was an AWS S3 bucket named:

```text
shivendra-demo-s3-bucket-03
```

---

## Step 4: Apply the Configuration

Applied the Terraform configuration.

```bash
terraform apply
```

After confirming with:

```text
yes
```

Terraform successfully created the S3 bucket.

**Output**

```text
Apply complete!

Resources: 1 added, 0 changed, 0 destroyed.
```

---

## Project Structure

```text
day-1/
├── main.tf
├── terraform.tf
├── terraform.tfstate
├── .terraform/
└── .terraform.lock.hcl
```

---

## Commands Used

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

---

## Challenges Faced

While running the commands, I accidentally typed:

```bash
terrafrom plan
```

which resulted in:

```text
Command 'terrafrom' not found
```

After correcting the spelling to:

```bash
terraform plan
```

the command executed successfully.

---

## What I Learned

- How to install and initialize Terraform.
- How to configure the AWS provider.
- How Terraform automatically uses AWS credentials configured through the AWS CLI.
- How to validate a Terraform configuration before deployment.
- How to preview infrastructure changes using `terraform plan`.
- How to provision cloud resources using `terraform apply`.
- The purpose of the `terraform.tfstate` file.
- How Terraform loads configuration from multiple `.tf` files automatically.

---

## Conclusion

Successfully installed and initialized Terraform, configured the AWS provider, validated the configuration, and provisioned my first AWS S3 bucket using Terraform.

This task helped me understand the complete Terraform workflow and how Infrastructure as Code (IaC) can be used to automate cloud infrastructure.

---

## Terraform Workflow

```text
Write Terraform Configuration
        │
        ▼
terraform init
        │
        ▼
terraform validate
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
AWS S3 Bucket Created ✅
```