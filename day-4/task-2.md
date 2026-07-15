# Task 2: Explore Local State & `terraform state`

## Objective

Learn how Terraform stores infrastructure information in the **local state file (`terraform.tfstate`)** and how to inspect and manage it using `terraform state` commands.

---

# What is Terraform State?

Terraform stores information about the infrastructure it creates inside a file called:

```
terraform.tfstate
```

This file acts as Terraform's database.

It keeps track of:

- Created resources
- Resource IDs
- Current configuration
- Resource attributes
- Dependencies

Without the state file, Terraform wouldn't know which resources it manages.

---

# 1. List All Managed Resources

### Command

```bash
terraform state list
```

### Purpose

Displays every resource currently managed by Terraform.

### My Output

```bash
data.aws_ami.my_ami
data.aws_ami.my_aws_ami
aws_default_vpc.my_vpc
aws_instance.day_3_shiv_instance
aws_instance.shiv_vpc_instance[0]
aws_instance.shiv_vpc_instance[1]
aws_internet_gateway.my_igw
aws_key_pair.my_aws_key
aws_route_table.my_route_table
aws_s3_bucket.east_bucket
aws_s3_bucket.west_bucket
aws_security_group.my_aws_security_group
aws_security_group.my_sg
aws_subnet.public
aws_vpc.main
aws_vpc_security_group_egress_rule.my_egress_rule
aws_vpc_security_group_ingress_rule.my_ingress_rule_ssh
```

### When to Use

- See everything Terraform currently manages.
- Find the correct resource address before running other `terraform state` commands.
- Debug state-related issues.

---

# 2. Inspect a Resource

### Command

```bash
terraform state show aws_internet_gateway.my_igw
```

### Purpose

Displays all attributes stored in the Terraform state for a specific resource.

### My Output

```text
ID      : igw-025f7dab1e378ccfc
Region  : us-west-2
VPC ID  : vpc-0569a239c319830cd
```

Terraform also displayed additional metadata like ARN, owner ID, and tags.

### When to Use

- Verify resource configuration.
- Check IDs.
- Debug resource properties.
- Understand the current infrastructure state.

---

# 3. Rename a Resource in State

### Command

```bash
terraform state mv \
aws_instance.day_3_shiv_instance \
aws_instance.shiv_vpc_instance3
```

### Output

```text
Successfully moved 1 object(s).
```

### Purpose

Renames or moves a resource **only inside Terraform state**.

**Important**

This does **NOT** rename the actual AWS EC2 instance.

Only Terraform's record is updated.

### When to Use

- Renaming resources in code.
- Refactoring Terraform configuration.
- Moving resources into modules.
- Preventing unnecessary resource recreation.

---

# 4. Remove Resource from State

### Command

```bash
terraform state rm aws_instance.shiv_vpc_instance3
```

### Output

```text
Successfully removed 1 resource instance(s).
```

### Purpose

Removes the resource from Terraform state **without deleting it from AWS**.

The EC2 instance continues to exist.

Terraform simply stops managing it.

### When to Use

- Stop managing an existing resource.
- Hand over management to another Terraform project.
- Import it later.
- Resolve state inconsistencies.

---

# 5. Display Entire Terraform State

### Command

```bash
terraform show
```

### Purpose

Prints the complete Terraform state in a human-readable format.

It includes:

- VPC
- Subnets
- Security Groups
- Internet Gateway
- Route Tables
- EC2 Instances
- S3 Buckets
- Key Pair
- Outputs
- Data Sources

### Example Information Displayed

For EC2 instances:

- Instance ID
- AMI
- Instance Type
- Private IP
- Availability Zone
- Security Group
- Root Volume
- Tags

For S3 buckets:

- Bucket Name
- Region
- Encryption
- Versioning
- ARN

For VPC:

- CIDR Block
- Route Tables
- Default Security Group
- DNS Settings

### When to Use

- Review the complete infrastructure state.
- Troubleshoot configuration.
- Verify deployed resources.
- Inspect outputs and resource attributes.

---

# Summary

| Command | What It Does | Does It Modify Infrastructure? |
|----------|--------------|--------------------------------|
| `terraform state list` | Lists all managed resources | ❌ No |
| `terraform state show` | Shows details of one resource | ❌ No |
| `terraform state mv` | Renames or moves a resource in state | ❌ No |
| `terraform state rm` | Removes a resource from state only | ❌ No |
| `terraform show` | Displays the entire Terraform state | ❌ No |

---

# Key Takeaways

- Terraform stores infrastructure information in the `terraform.tfstate` file.
- The state file is Terraform's source of truth for managed resources.
- `terraform state list` helps identify all managed resources.
- `terraform state show` displays detailed information about a specific resource.
- `terraform state mv` changes the resource address in the state without modifying the actual infrastructure.
- `terraform state rm` removes a resource from Terraform management but does not delete it from the cloud provider.
- `terraform show` provides a complete, human-readable view of the current infrastructure state and outputs.

> **Biggest takeaway:** The Terraform state file is the bridge between your code and your real cloud infrastructure. State commands let you inspect, reorganize, or stop tracking resources safely without directly changing the infrastructure, making Terraform management more flexible and reliable.