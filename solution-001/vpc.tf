resource "aws_vpc" "vpc-s001" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-s001"
  }
}

resource "aws_subnet" "subnet-s001-01" {

    vpc_id = aws_vpc.vpc-s001.id
    cidr_block = "10.0.1.0/25"
    availability_zone = "us-west-2a"

    tags = {
        Name = "subnet-s001-01"
    }
}
resource "aws_subnet" "subnet-s001-02" {

    vpc_id = aws_vpc.vpc-s001.id
    cidr_block = "10.0.2.0/25"
    availability_zone = "us-west-2b"

    tags = {
        Name = "subnet-s001-02"
    }
}
resource "aws_subnet" "subnet-s001-03" {

    vpc_id = aws_vpc.vpc-s001.id
    cidr_block = "10.0.3.0/25"
    availability_zone = "us-west-2c"

    tags = {
        Name = "subnet-s001-03"
    }
}