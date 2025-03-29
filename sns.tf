resource "aws_sns_topic" "RDS-notificatiion" {
    name = "RDS-notificatiion"
}

resource "aws_sns_topic_subscription" "RDS-email" {
    topic_arn = aws_sns_topic.RDS-notificatiion.arn
    protocol = "email"
    endpoint = "sonuchristo455@gmail.com"
  
}