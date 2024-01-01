resource "aws_s3_bucket" "example" {
  bucket = "test-bucket-20240101"

  tags = {
    Name        = "My bucket_test"
    Environment = var.tags.env
  }
}