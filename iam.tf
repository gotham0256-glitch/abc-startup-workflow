############################################
# iam.tf
#
# PURPOSE:
# - Reuse ONE existing IAM role everywhere
# - Attach it to EC2 via instance profile
# - Do NOT create any new IAM roles
#
# ROLE USED:
# arn:aws:iam::165742852730:role/GitHubActions-IaC-Deployer
############################################


############################################
# EC2 Instance Profile
#
# EC2 cannot directly assume an IAM role.
# It requires an instance profile.
#
# This instance profile attaches the SAME
# IAM role used by GitHub, ECS, Step Functions,
# and EventBridge.
############################################
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"

  # Extract role name from ARN
  role = split("/", var.iam_role_arn)[1]
}
