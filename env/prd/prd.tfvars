aws = {
  account_id = "481180291855"
}

ecs = {

}

rds = {
  instance_class          = "db.r6g.large"
  deletion_protection     = true
  backup_retention_period = 5
}

tags = {
  Environment = "prd"
}
