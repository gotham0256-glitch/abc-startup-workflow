# Share network IDs with other resources

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.main.id
}

output "security_group_id" {
  value = aws_security_group.main.id
}

# EC2 instance ID (used by Step Functions)
output "ec2_instance_id" {
  value = aws_instance.preprocess.id
}

# ECS cluster ARN
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.main.arn
}

# ECS task definition ARN
output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.processor.arn
}

# Step Functions ARN
output "step_function_arn" {
  value = aws_sfn_state_machine.workflow.arn
}

# S3 bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.transactions.bucket
}