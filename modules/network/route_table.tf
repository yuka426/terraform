resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_1.id
}

### Public 1
resource "aws_route_table" "public_route_table_1" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    cidr_block = "172.20.0.0/22"
    gateway_id = "local"
  }

  tags = {
    "Name" = "public_route_table_1"
  }
}

resource "aws_route_table_association" "public1_to_subnet1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table_1.id
}

### Public 2
resource "aws_route_table" "public_route_table_2" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    cidr_block = "172.20.0.0/22"
    gateway_id = "local"
  }

  tags = {
    "Name" = "public_route_table_2"
  }

}

resource "aws_route_table_association" "public2_to_subnet2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table_2.id
}

### Private 1
resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1.id
  }

  route {
    cidr_block = "172.20.0.0/22"
    gateway_id = "local"
  }

  tags = {
    "Name" = "private_route_table_1"
  }
}

resource "aws_route_table_association" "private1_to_subnet1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

### Private 2
resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1.id
  }

  route {
    cidr_block = "172.20.0.0/22"
    gateway_id = "local"
  }

  tags = {
    "Name" = "private_route_table_2"
  }
}

resource "aws_route_table_association" "private2_to_subnet2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}



