# ----------------------------------------
# S3 Bucket for transaction uploads
# force_destroy ensures bucket is deleted
# even if it contains files
# ----------------------------------------
resource "aws_s3_bucket" "transactions" {
  bucket        = var.s3_bucket_name
  force_destroy = true   # IMPORTANT: auto‑delete objects
}

# Enable EventBridge notifications
resource "aws_s3_bucket_notification" "eventbridge" {
  bucket      = aws_s3_bucket.transactions.id
  eventbridge = true
}

# ----------------------------------------
# EventBridge rule
# Triggers when a file is uploaded to S3
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
# Starts Step Functions automatically
# ----------------------------------------
resource "aws_cloudwatch_event_target" "stepfunction_target" {
  rule      = aws_cloudwatch_event_rule.s3_trigger.name
  target_id = "StartStepFunction"
  arn       = aws_sfn_state_machine.workflow.arn
  role_arn = aws_iam_role.eventbridge_role.arn
}