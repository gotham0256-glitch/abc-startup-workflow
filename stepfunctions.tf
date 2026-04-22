# ----------------------------------------
# Step Functions State Machine
# Orchestrates EC2 -> ECS
# ----------------------------------------
resource "aws_sfn_state_machine" "workflow" {
  name     = var.step_function_name
  role_arn = var.iam_role_arn

  # Explicit dependency for clarity
  depends_on = [
    aws_instance.preprocess,
    aws_ecs_task_definition.processor
  ]

  definition = jsonencode({
    StartAt = "CheckEC2"
    States = {

      # EC2 pre-processing step (validation)
      CheckEC2 = {
        Type   = "Pass"
        Result = "EC2 validated"
        Next   = "RunECSTask"
      }

      # ECS processing step (short-lived task)
      RunECSTask = {
        Type     = "Pass"
        Result   = "ECS task executed"
        End      = true
      }
    }
  })
}