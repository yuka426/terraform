### NAT Gateway 1
### NAT Gateway2つ作る？

resource "aws_eip" "nat_gateway_1" {
  domain = "vpc"

  tags = {
    Name = "nat_gateway_1_eip"
  }
}

resource "aws_nat_gateway" "nat_gw_1" {
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_gateway_1.id
  subnet_id         = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat_gateway_1"
  }

  depends_on = [aws_internet_gateway.igw]
}

# ### NAT Gateway 2
# resource "aws_eip" "nat_gateway_2" {
#   domain = "vpc"

#   tags = {
#     Name = "nat_gateway_2_eip"
#   }
# }

# resource "aws_nat_gateway" "nat_gw_2" {
#   connectivity_type = "public"
#   allocation_id = aws_eip.nat_gateway_2.id
#   subnet_id     = aws_subnet.public_subnet_2.id

#   tags = {
#     Name = "nat_gateway_2"
#   }

#   depends_on = [aws_internet_gateway.igw]
# }

