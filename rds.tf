resource "aws_db_subnet_group" "db_subnet_group" {
    subnet_ids = [ aws_subnet.private.id , aws_subnet.Public.id ]
    tags = {
      Name = "db-group"
    }
  
}

resource "aws_db_instance" "Db" {
    instance_class = "db.t3.micro"
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    db_name = "mydatabase"
    username = "admin"
    password = "password"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
    multi_az = true
    vpc_security_group_ids = [ aws_security_group.rds-sg.id ]
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    backup_retention_period = 7
    monitoring_interval = 60
    storage_encrypted = true
    kms_key_id = aws_kms_key.kms-key.arn

    monitoring_role_arn = aws_iam_role.RDS-monitoring.arn
    enabled_cloudwatch_logs_exports = [ "error","slowquery","general" ]

    tags = {
      Name = "Multi-AZ-RDS"
    }
  
}