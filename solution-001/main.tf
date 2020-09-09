# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key = "" # user access key here
  secret_key = "" # user secret key here
  # or
  # $ export AWS_ACCESS_KEY_ID="anaccesskey"
  # $ export AWS_SECRET_ACCESS_KEY="asecretkey"
}

terraform {
  required_version = "0.12.21"

# BEST-PRACTICE: create S3 bucket for storing terraform state file
# backend "s3" {
#   bucket = "terraform-state"
#   key = "terrafrom.tfstate"
#   region = var.region
# }
}

# 1. Create VPC
# 2. Create 3 subnets in different AZ
# 3. Deploy EC2 instances to subnets
# - 3 x EC2 in us-west-2a
# - 3 x EC2 in us-west-2b
# - 3 x EC2 in us-west-2c

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Deploy 3 x EC2 in us-west-2a
resource "aws_instance" "ec2-a" {
  count         = 3
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-s001-01.id
  tags = {
    Name = "ec2-${count.index}a"
  }
}

# Deploy 3 x EC2 in us-west-2b
resource "aws_instance" "ec2-b" {
  count         = 3
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-s001-02.id
  tags = {
    Name = "ec2-${count.index}b"
  }
}
# Deploy 3 x EC2 in us-west-2c
resource "aws_instance" "ec2-c" {
  count         = 3
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-s001-03.id
  tags = {
    Name = "ec2-${count.index}c"
  }
}
