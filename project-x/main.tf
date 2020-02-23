# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
  access_key = "" # user access key here
  secret_key = "" # user secret key here
}

terraform {
  required_version = "0.12.21"

# TODO: create S3 bucket for storing terraform state file
# backend "s3" {
#   bucket = "terraform-state"
#   key = "terrafrom.tfstate"
#   region = "us-east-2"
# }
}

# Add pub_key here to be able to login with ssh to ec2
# resource "aws_key_pair" "pub_key" {
#   key_name   = "" # user key_name here
#   public_key = "" # user public key here
# }

# Create VPC A with one subnet and EC2 instance
module "a-vpc" {
  source = "./components/a-vpc"

  vpc_cidr_block        = "10.1.0.0/16"
  
  subnet_1_name         = "a-subnet-1"
  a_subnet_1_cidr_block = "10.1.128.0/17"
  
  aws_key_pair          = "${aws_key_pair.pub_key.key_name}"
  ec2_instance_name     = "a-ec2"

}

# Create VPC B with two subnets, EC2 instance
module "b-vpc" {
  source = "./components/b-vpc"

  vpc_cidr_block        = "10.2.0.0/16"

  subnet_1_name         = "b-subnet-1"
  b_subnet_1_cidr_block = "10.2.64.0/18"
  
  subnet_2_name         = "b-subnet-2"
  b_subnet_2_cidr_block = "10.2.128.0/18"
  
  aws_key_pair          = "${aws_key_pair.pub_key.key_name}"
  ec2_instance_name     = "b-ec2"

}

# Connect VPC A with VPC B. VPC Peering
resource "aws_vpc_peering_connection" "a-to-b" {
  peer_vpc_id   = "${module.a-vpc.vpc_id}"
  vpc_id        = "${module.b-vpc.vpc_id}"
  auto_accept   = true

  tags = {
    Name = "a-to-b vpc peering"
  }
}

# Create route in default VPC A route table to VPC B
module "a-subnet-1-to-b-subnet-1" {
  source = "./modules/network/route"
  
  route_table_id            = "${module.a-vpc.default_route_table_id}"
  destination_cidr_block    = "${module.b-vpc.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.a-to-b.id}"
}

# Create route in default VPC B route table to VPC A
module "b-subnet-1-to-a-subnet-1" {
  source = "./modules/network/route"
  
  route_table_id            = "${module.b-vpc.default_route_table_id}"
  destination_cidr_block    = "${module.a-vpc.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.a-to-b.id}"
}

# Create security rule for VPC A for icmp and ssh 
module "a-icmp-ssh-sec-rule" {
  source = "./modules/security/security-group"
  
  vpc_id        = "${module.a-vpc.vpc_id}"
  in_icmp_cidr_blocks = ["${module.b-vpc.vpc_cidr}"]
  in_ssh_cidr_blocks  = ["0.0.0.0/0"]
}

# Create security rule for VPC B for icmp 
module "b-icmp-ssh-sec-rule" {
  source = "./modules/security/security-group"
  
  vpc_id        = "${module.b-vpc.vpc_id}"
  in_icmp_cidr_blocks = ["${module.a-vpc.vpc_cidr}"]
}

# Create S3 bucket
module "s3-bucket" {
  source = "./modules/storage/s3-bucket"
  
  bucket_name = "project-x-s3-bucket"
  bucket_dns = "project-x-s3-bucket-dns"

}
