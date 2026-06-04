variable "instance_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  ami           = var.ami != "" ? var.ami : data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  value = aws_instance.this.id
}

output "instance_name" {
  value = var.instance_name
}
