resource "aws_s3_bucket" "example" {
  bucket = "test-bucket-20231217"

  tags = {
    Name        = "My bucket_test"
    Environment = "Dev"
  }
}