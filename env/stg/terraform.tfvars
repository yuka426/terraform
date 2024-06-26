aws = {
  region = "ap-northeast-1"
}

ecs = {
  desired_count = 1
}

rds = {
  instance_class          = "db.t3.medium"
  deletion_protection     = false
  backup_retention_period = 1
}

tags = {
  Environment = "stg"
}

