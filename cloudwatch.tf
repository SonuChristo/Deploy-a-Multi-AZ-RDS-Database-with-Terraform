resource "aws_cloudwatch_log_group" "cloudwatch" {
    name = "/aws/rds/instance/${aws_db_instance.Db.id}"
    retention_in_days = 30  
}

resource "aws_cloudwatch_metric_alarm" "RDS-CPU-alarm" {
    alarm_name = var.alarm_name_CPU
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 2
    metric_name = var.metric_name_cpu
    namespace = "AWS/RDS"
    period = 60
    statistic = "Average"
    threshold = 80
    alarm_description = "Triggers when CPU utilization exceeds 80%."
    actions_enabled = true
    alarm_actions = [ aws_sns_topic.RDS-notificatiion.arn ]
    ok_actions = [ aws_sns_topic.RDS-notificatiion.arn ]
    dimensions = {
       DBInstanceIdentifier = aws_db_instance.Db.id 
    }
}

resource "aws_cloudwatch_metric_alarm" "RDS-low-storage" {
    alarm_name = var.alarm_name_storage
    comparison_operator = "LessThanThreshold"
    evaluation_periods = 2
    metric_name = var.metric_name_storage
    namespace = "AWS/RDS"
    period = 60
    statistic = "Average"
    threshold = 4294967296
    alarm_description = "Triggers when free storage is below 20%."
    actions_enabled = true
    alarm_actions = [ aws_sns_topic.RDS-notificatiion.arn ]
    ok_actions = [ aws_sns_topic.RDS-notificatiion.arn ]
    dimensions = {
      DBInstanceIdentifier = aws_db_instance.Db.id
    }
  
}