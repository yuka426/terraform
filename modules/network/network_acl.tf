
### Public
resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.vpc_1.id
  tags = {
    "Name" = "public_acl"
  }
}

resource "aws_network_acl_rule" "allow_https_ingress" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 10
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "allow_http_ingress" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 20
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "allow_ephemeral_ingress" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 30
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "allow_https_egress" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 10
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "allow_http_egress" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 20
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "allow_ephemeral_egress" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 30
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_association" "public_1" {
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_network_acl_association" "public_2" {
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

### Private
resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.vpc_1.id
  tags = {
    "Name" = "private_acl"
  }
}

resource "aws_network_acl_rule" "allow_internal_ingress" {
  network_acl_id = aws_network_acl.private_acl.id
  rule_number    = 10
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = aws_vpc.vpc_1.cidr_block
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "allow_internal_egress_all" {
  network_acl_id = aws_network_acl.private_acl.id
  rule_number    = 10
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = aws_vpc.vpc_1.cidr_block
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_association" "private_1" {
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

resource "aws_network_acl_association" "private_2" {
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = aws_subnet.private_subnet_2.id
}

