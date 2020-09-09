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

# Key Pair to use for the instance
resource "aws_key_pair" "key" {
  key_name   = "devops-ssh-key"
  public_key = "ssh-rsa AAAA..."
}

# Deploy EC2 to public subnet
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ubuntu.id                 # (Required) The AMI to use for the instance.
  instance_type          = "t2.micro"                             # (Required) The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance.
  subnet_id              = aws_subnet.public-subnet-001.id        # (Optional) The VPC Subnet ID to launch in.
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"] # (Optional, VPC only) A list of security group IDs to associate with.
  key_name               = aws_key_pair.key.key_name              # (Optional) The key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource.
  tags = {
    Name = "${var.prefix}-ec2-001"
  }
}

# Create Security Group to allow SSH traffic
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"                     # (Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name
  description = "Allow SSH inbound traffic"     # (Optional, Forces new resource) The security group description. Defaults to "Managed by Terraform". Cannot be "". NOTE: This field maps to the AWS
  vpc_id      = aws_vpc.vpc-001.id              # (Optional, Forces new resource) The VPC ID.

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-allow_ssh"
  }
}