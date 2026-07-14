resource "aws_s3_bucket" "west_bucket" {
  bucket = "west-demo-bucket-day3"
}

resource "aws_s3_bucket" "east_bucket" {
  provider = aws.east
  bucket   = "east-demo-bucket-day3"
}