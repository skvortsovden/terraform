variable "vpc_cidr_block" {
  default   = "10.2.0.0/16"
}
variable "subnet_1_name" {
  default   = "b-subnet-1"
}
variable "b_subnet_1_cidr_block" {
  default   = "10.2.64.0/18"
}
variable "subnet_2_name" {
  default   = "b-subnet-2"
}
variable "b_subnet_2_cidr_block" {
  default   = "10.2.128.0/18"
}
variable "aws_key_pair" {
  default   = ""
}
variable "ec2_instance_name" {
  default   = "b-ec2"
}
