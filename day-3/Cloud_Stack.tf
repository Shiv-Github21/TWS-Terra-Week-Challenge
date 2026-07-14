#we are writting a full stack :
# internet --> vpc ---> subnets ---> internet gateway --> route table --> ec2-instance  using terraform    
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "shiv-vpc-tws"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.availability_zones[0]
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my_aws_sg"
  description = "Security group for my-server"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "my-server-sg"
  }
}
data "aws_ami" "my_ami" {
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

resource "aws_instance" "shiv_vpc_instance" {
  ami                    = data.aws_ami.my_ami.id
  count = 2
  instance_type          = var.instance_type
  availability_zone      = var.availability_zones[0]
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.public.id

  depends_on = [
    aws_internet_gateway.my_igw
  ]

  lifecycle {
    create_before_destroy = true
    //prevent_destroy = true
    ignore_changes = [
    tags
  ]
  }

tags = {
  Name = "Shiv-vpc-TWS-${count.index}"
}
}