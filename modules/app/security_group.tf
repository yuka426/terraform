### ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "ALB Secuirty Group"
  vpc_id      = var.vpc_id
  tags = {
    Name = "alb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_ingress_http" {
  security_group_id = aws_security_group.alb_sg.id
  description       = "From Internet"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "alb_ingress_https" {
  security_group_id = aws_security_group.alb_sg.id
  description       = "From Internet"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

### ECS
resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "ECS Secuirty Group"
  vpc_id      = var.vpc_id
  tags = {
    Name = "ecs_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_ingress_ecs" {
  security_group_id            = aws_security_group.ecs_sg.id
  description                  = "From ALB"
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_vpc_security_group_egress_rule" "ecs_egress" {
  security_group_id = aws_security_group.ecs_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

### RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  vpc_id      = var.vpc_id
  description = "Security Group For RDS"
  tags = {
    Name = "rds_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_ingress_ecs" {
  security_group_id            = aws_security_group.rds_sg.id
  description                  = "From ECS"
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.ecs_sg.id
}

resource "aws_vpc_security_group_egress_rule" "rds_egress" {
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}