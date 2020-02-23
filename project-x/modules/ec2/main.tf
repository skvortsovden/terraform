
# Get data about AMI, Ubuntu as example
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create EC2 instance
resource "aws_instance" "a_instance" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name      = "${var.pub_key_name}"
  tags = {
    Name = "${var.instance_name}"
  }
}
