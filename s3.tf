# ----------------------------------------
# S3 Bucket for transaction uploads
# ----------------------------------------
resource "aws_s3_bucket" "transactions" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

# Enable EventBridge notifications
resource "aws_s3_bucket_notification" "eventbridge" {
  bucket      = aws_s3_bucket.transactions.id
  eventbridge = true
}

# ----------------------------------------
# EventBridge rule
# Triggers on S3 object upload
# ----------------------------------------
resource "aws_cloudwatch_event_rule" "s3_trigger" {
  name = "${var.project_name}-s3-trigger"

  event_pattern = jsonencode({
    source      = ["aws.s3"],
    detail-type = ["Object Created"],
    detail = {
      bucket = {
        name = [aws_s3_bucket.transactions.bucket]
      }
    }
  })
}

# ----------------------------------------
# EventBridge target
# Starts Step Functions
# (USES THE SAME SINGLE IAM ROLE)
# ----------------------------------------
resource "aws_cloudwatch_event_target" "stepfunction_target" {
  rule      = aws_cloudwatch_event_rule.s3_trigger.name
  target_id = "StartStepFunction"
  arn       = aws_sfn_state_machine.workflow.arn

  #Single IAM role reused
  role_arn = var.iam_role_arn
}