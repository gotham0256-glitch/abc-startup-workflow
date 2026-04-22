# ----------------------------------------
# ECS Cluster
# Holds short‑lived ECS tasks
# ----------------------------------------
resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

# ----------------------------------------
# ECS Task Definition
# Represents processing step
# ----------------------------------------
resource "aws_ecs_task_definition" "processor" {
  family                   = "${var.project_name}-processor"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory

  # Task will use the same IAM role (later wired)
  execution_role_arn = var.iam_role_arn
  task_role_arn      = var.iam_role_arn

  container_definitions = jsonencode([
    {
      name      = "processor"
      image     = var.ecs_container_image
      essential = true
    }
  ])
}