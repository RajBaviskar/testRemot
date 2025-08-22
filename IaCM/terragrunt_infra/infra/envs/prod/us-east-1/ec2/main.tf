variable "instance_type" {}
variable "instance_count" { type = number }
variable "tags" { type = map(string) }
variable "environment" {}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  count         = var.instance_count
  tags = merge(var.tags, { Name = "${var.environment}-ec2-${count.index}" })
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
