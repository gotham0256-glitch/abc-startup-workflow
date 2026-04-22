# ------------------------
# General configuration
# ------------------------

# AWS region for all resources
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

# Common name prefix for tagging
variable "project_name" {
  type    = string
  default = "abc-startup"
}


# ------------------------
# Networking
# ------------------------

# CIDR for VPC
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# CIDR for subnet
variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}


# ------------------------
# EC2 (Pre‑processing)
# ------------------------

# AMI for EC2
variable "ec2_ami" {
  type    = string
  default = "ami-05d2d839d4f73aafb"
}

# EC2 instance type
variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}


# ------------------------
# ECS (Processing)
# ------------------------

# ECS cluster name
variable "ecs_cluster_name" {
  type    = string
  default = "abc-startup-cluster"
}

# ECS task CPU units
variable "ecs_task_cpu" {
  type    = string
  default = "256"
}

# ECS task memory (MiB)
variable "ecs_task_memory" {
  type    = string
  default = "512"
}

# Container image for ECS processing task
# Use Amazon ECR public mirror (no Docker Hub limits)
variable "ecs_container_image" {
  type    = string
  default = "public.ecr.aws/nginx/nginx:stable"
}

# ------------------------
# IAM (Single role reused)
# ------------------------

# IAM role ARN reused by:
# - GitHub Actions
# - ECS task
# - Step Functions
variable "iam_role_arn" {
  type        = string
  description = "Single IAM role ARN reused across GitHub, ECS, and Step Functions"
}


# ------------------------
# Step Functions
# ------------------------

# Step Functions state machine name
variable "step_function_name" {
  type    = string
  default = "abc-startup-workflow"
}


# ------------------------
# S3 (Transaction input)
# ------------------------

# S3 bucket for transaction uploads
# Must be globally unique
variable "s3_bucket_name" {
  type        = string
  default = "2472737-usecase-bucket"
  description = "Bucket used to upload transaction files"
}


# ------------------------
# EventBridge
# ------------------------

# Role used by EventBridge to start Step Functions
variable "eventbridge_role_name" {
  type    = string
  default = "eventbridge-stepfunctions-role"
}