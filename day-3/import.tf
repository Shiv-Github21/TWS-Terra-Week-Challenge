resource "aws_s3_bucket" "imported" {
}

import {
  to = aws_s3_bucket.imported
  id = "my-aws-console-bucket-shiv"
}