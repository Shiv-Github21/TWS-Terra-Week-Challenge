# 🧩 Terraform Provider Alias – How Does Terraform Know Which Provider to Use?

## Question

Consider the following Terraform configuration:

```hcl
provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

resource "aws_s3_bucket" "west_bucket" {
  bucket = "west-demo-bucket"
}

resource "aws_s3_bucket" "east_bucket" {
  provider = aws.east
  bucket   = "east-demo-bucket"
}
```

### ❓ Question

How does the first bucket know where to be created?

---

# ✅ Answer

Terraform automatically uses the **default provider**.

The provider block **without an `alias`** is called the **default provider**.

```hcl
provider "aws" {
  region = "us-west-2"
}
```

This is the default AWS provider.

Whenever a resource **does not specify a `provider`**, Terraform automatically uses this default provider.

For example:

```hcl
resource "aws_s3_bucket" "west_bucket" {
  bucket = "west-demo-bucket"
}
```

Even though we didn't write a provider inside the resource, Terraform internally treats it like this:

```hcl
resource "aws_s3_bucket" "west_bucket" {
  provider = aws
  bucket   = "west-demo-bucket"
}
```

Therefore, the bucket is created in the **us-west-2** region.

---

# Second Bucket

```hcl
resource "aws_s3_bucket" "east_bucket" {
  provider = aws.east
  bucket   = "east-demo-bucket"
}
```

Here we are explicitly telling Terraform:

> "Don't use the default provider. Use the provider whose alias is `east`."

Terraform looks for the provider configuration with the alias:

```hcl
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}
```

Therefore, this bucket is created in the **us-east-1** region.

---

# Visual Diagram

```text
               Terraform

                   |
        ------------------------
        |                      |
Default Provider         Alias Provider
(region = us-west-2)     alias = east
                          region = us-east-1
        |                      |
        |                      |
 west_bucket              east_bucket
```

---

# Easy Rule to Remember

✅ **No `provider = ...`**

* Terraform uses the **default provider**.

```hcl
resource "aws_s3_bucket" "bucket1" {
  bucket = "my-bucket"
}
```

This bucket is created using the default AWS provider.

---

✅ **`provider = aws.east`**

* Terraform uses the provider whose alias is **east**.

```hcl
resource "aws_s3_bucket" "bucket2" {
  provider = aws.east
  bucket   = "my-east-bucket"
}
```

This bucket is created in the region configured for the **east** provider.

---

# Interview Question

### Q. What happens if we don't specify `provider` inside a resource?

### Answer

If a resource does not specify a `provider`, Terraform automatically uses the **default provider configuration**, which is the provider block without an `alias`.

If we want a resource to use a different AWS region or account, we explicitly specify a provider alias, such as:

```hcl
provider = aws.east
```

---

# Key Takeaways

* A provider block **without an alias** is the **default provider**.
* Terraform automatically uses the default provider if no provider is specified in a resource.
* A provider alias lets us create resources in different AWS regions or accounts.
* Use `provider = aws.<alias>` whenever you want Terraform to use a non-default provider.
