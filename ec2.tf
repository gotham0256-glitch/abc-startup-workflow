# ----------------------------------------
# EC2 instance for pre‑processing step
# ----------------------------------------
resource "aws_instance" "preprocess" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  # Attach single IAM role via instance profile ✅
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "${var.project_name}-preprocess-ec2"
  }
}