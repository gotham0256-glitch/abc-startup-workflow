# ------------------------
# General configuration
# ------------------------

# AWS region for all resources
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

# Common name prefix for all resources
variable "project_name" {
  type    = string
  default = "abc-startup"
}


# ------------------------
# Networking
# ------------------------

# CIDR block for VPC
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# CIDR block for subnet
variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}


# ------------------------
# EC2 (Pre‑processing)
# ------------------------

# AMI for EC2 instance
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

# ECS container image (stable, no Docker Hub limits)
variable "ecs_container_image" {
  type    = string
  default = "public.ecr.aws/nginx/nginx:stable"
}


# ------------------------
# IAM (ONE role used everywhere)
# ------------------------

# Single IAM role reused by:
# - GitHub Actions (deploy/destroy)
# - EC2
# - ECS tasks
# - Step Functions
# - EventBridge
variable "iam_role_arn" {
  type    = string
  default = "arn:aws:iam::165742852730:role/GitHubActions-IaC-Deployer"
}


# ------------------------
# Step Functions
# ------------------------

# Step Functions workflow name
variable "step_function_name" {
  type    = string
  default = "abc-startup-workflow"
}


# ------------------------
# S3 (Transaction input)
# ------------------------

# S3 bucket for transaction file uploads
# Must be globally unique
variable "s3_bucket_name" {
  type        = string
  default     = "2472737-usecase-bucket"
  description = "Bucket used to upload transaction files"
}
