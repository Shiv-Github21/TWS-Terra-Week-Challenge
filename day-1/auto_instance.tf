/* 1. ami - amazone machine image
2. instance_type = t2.micro , t3.medium
3. availability_zone - us-west-2a, us-west-2b
4. key_name = private key , public key
5. security_group - allow inbound and outbound traffic rules
6. tags, names
storage/volumes */

#AMI
//we have n numbers of ami images in aws, we can use data source to get the latest ami image id for our instance creation
data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["099720109477"] # owner id for amazon linux 2

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

//name & tages


resource "aws_key_pair" "my_key_pair" {
  key_name   = "terra-auto-server-key"
  public_key = file("/home/shiv/.ssh/terra-auto-server-key.pub")
}

//vpc

resource "aws_default_vpc" "my_vpc" {
}


//sg
resource "aws_security_group" "my_security_group" {
  name        = "terra-auto-server-sg"
  description = "Security group for terra-auto-server"
  vpc_id      = aws_default_vpc.my_vpc.id
  tags = {
    Name = "terra-auto-server-sg"
  }
}

//ingress rule 
resource "aws_vpc_security_group_ingress_rule" "my_ingress_rule_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  from_port         = 22 //ssh port
  to_port           = 22 //ssh port
  ip_protocol          = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

//egress rule
resource "aws_vpc_security_group_egress_rule" "my_egress_rule" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol          = "-1"
}

//storage/volumes
# resource "aws_ebs_volume" "my_volume" {
#   availability_zone = var.aws_availability_zone
#   size              = 25 //size in GB
#   tags = {
#     Name = "terra-auto-server-volume"
#   }
# }

//aws_instance resource block
resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.my_ami.id
  instance_type          = var.aws_instance_type
#   volume_id              = aws_ebs_volume.my_volume.id
  availability_zone      = var.aws_availability_zone
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  root_block_device {
    volume_type = "gp3"
    volume_size = 25
  }
   tags = {
    Name = "shiv-terra-auto-server"
  }
}