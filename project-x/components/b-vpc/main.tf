# Create VPC B
module "b-vpc" {
  source = "../../modules/vpc"

  name = "b-pvc"
  cidr = "${var.vpc_cidr_block}"
  
}

# Create Subnet 1 inside VPC B
module "b-subnet-1" {
  source = "../../modules/network/subnet"

  subnet_name = "${var.subnet_1_name}"
  cidr_block  = "${var.b_subnet_1_cidr_block}"
  vpc_id      = "${module.b-vpc.vpc_id}"

}

# Create Subnet 2 inside VPC B
module "b-subnet-2" {
  source = "../../modules/network/subnet"

  subnet_name = "${var.subnet_2_name}"
  cidr_block  = "${var.b_subnet_2_cidr_block}"
  vpc_id      = "${module.b-vpc.vpc_id}"

}

# Create EC2 instance in VPC B subnet 1
module "b-ec2" {
  source = "../../modules/ec2"

  instance_name = "${var.ec2_instance_name}"
  pub_key_name  = "${var.aws_key_pair}" 
  subnet_id     = "${module.b-subnet-1.subnet_id}"
  associate_public_ip_address = true
 
}
