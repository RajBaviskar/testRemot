data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  count = var.instance_count

  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  
  # This worked in provider 4.x, but provider 5.x changed validation rules
  # Cannot specify both subnet_id and vpc_security_group_ids with network_interface attachment
# Remove subnet_id (ENI defines the subnet)
  vpc_security_group_ids = ["sg-12345"]
  
  network_interface {
    device_index          = 0
    network_interface_id  = "eni-12345"  # Attaching existing interface conflicts with subnet_id
    delete_on_termination = false
  }

  tags = {
    Name        = "${var.environment}-instance-${count.index + 1}"
    Environment = var.environment
    Owner       = var.owner
  }
}
