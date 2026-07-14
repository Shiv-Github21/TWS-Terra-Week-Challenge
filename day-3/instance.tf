resource "aws_key_pair" "my_aws_key" {
  key_name   = "day-3-shiv-key"
  public_key = file("${path.module}/day-3-instance-key.pub")
}

resource "aws_default_vpc" "my_vpc" {
  tags = {
    Name = "Shiv-VPC"
  }
}

data "aws_ami" "my_aws_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]

  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "my_aws_security_group" {
  name        = "terra-auto-server-sg"
  description = "Security group for terra-auto-server"
  vpc_id      = aws_default_vpc.my_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "my_ingress_rule_ssh" {
  security_group_id = aws_security_group.my_aws_security_group.id
  from_port         = 22 //ssh port
  to_port           = 22 //ssh port
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "my_egress_rule" {
  security_group_id = aws_security_group.my_aws_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
resource "aws_instance" "day_3_shiv_instance" {
  ami                    = data.aws_ami.my_aws_ami.id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zones[0]
  key_name               = aws_key_pair.my_aws_key.key_name
  vpc_security_group_ids = [aws_security_group.my_aws_security_group.id]
  root_block_device {
    volume_type = "gp3"
    volume_size = 25
  }
  tags = {
    Name = "shiv-day-3-server"
  }
}