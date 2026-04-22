# ----------------------------------------
# EC2 instance for pre‑processing step
# Created once via Terraform
# Later validated/checked by Step Functions
# ----------------------------------------
resource "aws_instance" "preprocess" {
  # AMI and instance size from variables
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  # Dependency on networking (automatic via references)
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "${var.project_name}-preprocess-ec2"
  }
}