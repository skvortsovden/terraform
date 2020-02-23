variable "vpc_cidr_block" {
  default   = "10.1.0.0/16"
}
variable "a_subnet_1_cidr_block" {
  default   = "10.1.128.0/17"
}

variable "aws_key_pair" {
  default   = ""
}

variable "ec2_instance_name" {
  default   = "a-ec2"
}

variable "subnet_1_name" {
  default   = "a-subnet-1"
}

variable "route_table_id" {
  default   = ""
}
