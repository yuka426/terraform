resource "aws_vpc" "vpc_1" {
  cidr_block           = "172.20.0.0/22"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "emptio"
  }
}