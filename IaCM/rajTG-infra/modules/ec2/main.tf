resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.iam_role_name}-profile"
  role = var.iam_role_name
}

resource "aws_instance" "app" {
  ami                  = "ami-0c02fb55956c7d316" # Amazon Linux 2, us-east-1
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name        = "${var.env}-raj-ec2"
    Environment = var.env
  }
}
