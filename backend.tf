resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state"
  versioning {
    enabled = true
  }
}

backend "s3" {
  bucket = "erraform-state"
  key    = "terraform.tfstate"
  region = "ap-northeast-1"
}