# ----------------------------------------
# Step Functions State Machine
# Orchestrates EC2 -> ECS
# ----------------------------------------
resource "aws_sfn_state_machine" "workflow" {
  name     = var.step_function_name
  role_arn = var.iam_role_arn

  depends_on = [
    aws_instance.preprocess,
    aws_ecs_task_definition.processor
  ]

  definition = jsonencode({
    StartAt = "CheckEC2",
    States = {

      # ----------------------------------
      # EC2 validation step
      # ----------------------------------
      CheckEC2 = {
        Type   = "Pass"
        Result = "EC2 validated"
        Next   = "RunECSTask"
      },

      # ----------------------------------
      # ECS processing step
      # ----------------------------------
      RunECSTask = {
        Type     = "Task"
        Resource = "arn:aws:states:::ecs:runTask.sync"
        Parameters = {
          LaunchType = "FARGATE"
          Cluster   = aws_ecs_cluster.main.arn
          TaskDefinition = aws_ecs_task_definition.processor.arn

          NetworkConfiguration = {
            AwsvpcConfiguration = {
              Subnets        = [aws_subnet.main.id]
              SecurityGroups = [aws_security_group.main.id]
              AssignPublicIp = "ENABLED"
            }
          }
        }
        End = true
      }
    }
  })
}