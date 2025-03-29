resource "aws_kms_key" "kms-key" {
    deletion_window_in_days = 7
    enable_key_rotation = true
    description = "KMS key for RDS encryprion"
}

resource "aws_kms_alias" "kms-alias" {
    name = "alias/kms-key"
    target_key_id = aws_kms_key.kms-key.key_id
  
}