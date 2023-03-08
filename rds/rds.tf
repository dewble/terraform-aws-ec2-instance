# AWS provider 설정
provider "aws" {
  region = "us-east-1"
}

# VPC 설정
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

# RDS 서브넷 그룹 설정
resource "aws_db_subnet_group" "example_subnet_group" {
  name       = "example-subnet-group"
  subnet_ids = [aws_subnet.example_subnet_1.id, aws_subnet.example_subnet_2.id]
}

# RDS 클러스터 생성
resource "aws_rds_cluster" "example_cluster" {
  cluster_identifier   = "example-cluster"
  engine               = "postgres"
  engine_version       = "13.2"
  database_name        = "example-db"
  master_username      = "example-user"
  master_password      = "example-password"
  backup_retention_period = 7
  preferred_backup_window = "01:00-02:00"

  vpc_security_group_ids = [aws_security_group.example_security_group.id]

  db_subnet_group_name = aws_db_subnet_group.example_subnet_group.name
  db_cluster_parameter_group_name = "default.postgres13"
  skip_final_snapshot = true

  tags = {
    Name = "example-cluster"
  }
}

# RDS 인스턴스 생성
resource "aws_rds_cluster_instance" "example_instance" {
  count = 2

  identifier = "example-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.example_cluster.id
  instance_class = "db.t3.small"
  engine = "postgres"
  engine_version = "13.2"
  db_subnet_group_name = aws_db_subnet_group.example_subnet_group.name
  vpc_security_group_ids = [aws_security_group.example_security_group.id]

  tags = {
    Name = "example-instance-${count.index}"
  }
}