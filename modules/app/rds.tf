resource "aws_rds_cluster" "rds" {
  cluster_identifier              = "rds-cluster"
  engine                          = "aurora-postgresql"
  engine_version                  = "14.8" ### ストレージの動的なスケーリングは14まで対応
  availability_zones              = ["ap-northeast-1a", "ap-northeast-1c"]
  db_subnet_group_name            = aws_db_subnet_group.rds.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds.name
  port                            = 5432

  storage_encrypted      = true
  copy_tags_to_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  database_name   = "emptio_db"
  master_username = "emptio_user"
  master_password = random_password.rds_password.result

  backup_retention_period         = var.rds.backup_retention_period ### 自動バックアップ保持日数
  preferred_maintenance_window    = "mon:18:00-mon:18:30"           ###　mon3:00-3:30(JST) 週次で一番アクセスが少なそうな時間帯
  preferred_backup_window         = "15:00-17:30"                   ### 0:00-2:30(JST) 日次で一番アクセスが少なそうな時間帯
  enabled_cloudwatch_logs_exports = ["postgresql"]
  deletion_protection             = var.rds.deletion_protection ### 本番環境のみ有効化

  depends_on = [aws_rds_cluster_parameter_group.rds]

  lifecycle {
    ignore_changes = [
      availability_zones
    ]
  }
}

resource "aws_rds_cluster_instance" "rds" {
  count = 2 ### 検証2つ→1つ 本番2つ

  cluster_identifier = aws_rds_cluster.rds.id
  identifier         = "rds-instance-${count.index}"
  ca_cert_identifier = "rds-ca-rsa2048-g1" ### SSL接続を必須にするならパラメータグループの変更が必要(rds.force_ssl)

  engine                  = aws_rds_cluster.rds.engine
  engine_version          = aws_rds_cluster.rds.engine_version
  instance_class          = var.rds.instance_class ###検証：db.t4g.medium, 本番：db.r6g.large
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  db_parameter_group_name = aws_db_parameter_group.rds.name
  publicly_accessible     = false

  depends_on = [aws_db_parameter_group.rds]
}

resource "aws_db_parameter_group" "rds" {
  name   = "rds-psql-instance-pg"
  family = "aurora-postgresql14"

  parameter {
    ### コネクション接続をログ出力
    name         = "log_connections"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    ### コネクション切断をログ出力
    name         = "log_disconnections"
    value        = "1"
    apply_method = "pending-reboot"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_cluster_parameter_group" "rds" {
  name   = "rds-psql-cluster-pg"
  family = "aurora-postgresql14"

  parameter {
    ### コネクション接続をログ出力
    name         = "log_connections"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    ### コネクション切断をログ出力
    name         = "log_disconnections"
    value        = "1"
    apply_method = "pending-reboot"
  }
}

resource "random_password" "rds_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "rds_password" {
  name  = "rds_password"
  type  = "SecureString"
  value = aws_rds_cluster.rds.master_password
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds_subnet_group"
  subnet_ids = var.subnet_ids.private
}


