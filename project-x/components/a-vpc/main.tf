
# Create VPC A
module "a-vpc" {
  source = "../../modules/vpc"

  name = "a-pvc"
  cidr = "${var.vpc_cidr_block}"
  
}

# Create Internet Gateway for VPC A
module "a-internet-gateway" {
  source = "../../modules/network/internet-gateway"
  
  name   = "a-internet-gateway"
  vpc_id = "${module.a-vpc.vpc_id}"
}

# Create Subnet 1 inside VPC A
module "a-subnet-1" {
  source = "../../modules/network/subnet"

  subnet_name = "${var.subnet_1_name}"
  cidr_block  = "${var.a_subnet_1_cidr_block}"
  vpc_id      = "${module.a-vpc.vpc_id}"

}

# Create EC2 instance in VPC A subnet 1
module "a-ec2" {
  source = "../../modules/ec2"
  
  instance_name = "${var.ec2_instance_name}"
  pub_key_name  = "${var.aws_key_pair}" 
  subnet_id     = "${module.a-subnet-1.subnet_id}"
  associate_public_ip_address = true
}

# Create Route for VPC A to internet gateway
module "a-vpc-to-internet" {
  source = "../../modules/network/route"
  
  route_table_id            = "${module.a-vpc.default_route_table_id}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = "${module.a-internet-gateway.gateway_id}"

}

