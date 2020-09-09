resource "aws_vpc" "vpc-001" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.prefix}-vpc-001"
  }
}

# map_public_ip_on_launch: This is so important.
# The only difference between private and public subnet is this line. 
# If it is true, it will be a public subnet, otherwise private.

resource "aws_subnet" "public-subnet-001" {

    cidr_block = "10.0.1.0/25"              # (Required) The CIDR block for the subnet.
    vpc_id = aws_vpc.vpc-001.id             # (Required) The VPC ID.
    availability_zone = "us-west-2a"        # (Optional) The AZ for the subnet.
    map_public_ip_on_launch = "true"        # (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false.
    # availability_zone_id = ""             # (Optional) The AZ ID of the subnet.
    # outpost_arn = ""                      # (Optional) The Amazon Resource Name (ARN) of the Outpost.
    # assign_ipv6_address_on_creation = ""  # (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false
    tags = {
        Name = "${var.prefix}-subnet-001"
    }
}

resource "aws_subnet" "private-subnet-002" {

    cidr_block = "10.0.2.0/25"              # (Required) The CIDR block for the subnet.
    vpc_id = aws_vpc.vpc-001.id             # (Required) The VPC ID.
    availability_zone = "us-west-2a"        # (Optional) The AZ for the subnet.
    # availability_zone_id = ""             # (Optional) The AZ ID of the subnet.
    # map_public_ip_on_launch = "true"      # (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false.
    # outpost_arn = ""                      # (Optional) The Amazon Resource Name (ARN) of the Outpost.
    # assign_ipv6_address_on_creation = ""  # (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false
    tags = {
        Name = "${var.prefix}-subnet-002"
    }
}

# Create IGW and attach it to VPC
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-001.id          # (Required) The VPC ID to create in.

    tags = {
        Name = "${var.prefix}-igw-001"
    }
}

# Create Private RT
resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.vpc-001.id          # (Required) The VPC ID to create in.

    tags = {
        Name = "${var.prefix}-private-rt"
    }
}
# Associate Private RT with private subnet
resource "aws_route_table_association" "a" {
    # Please note that one of either subnet_id or gateway_id is required.
    route_table_id = aws_route_table.private-rt.id        # (Required) The ID of the routing table to associate with.
    subnet_id      = aws_subnet.private-subnet-002.id     # (Optional) The subnet ID to create an association. Conflicts with gateway_id.
    # gateway_id   = ""                                   # (Optional) The gateway ID to create an association. Conflicts with subnet_id.
}

# Create Public RT
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.vpc-001.id          # (Required) The VPC ID to create in.

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.prefix}-public-rt"
    }
}

# Associate Public RT with public subnet
resource "aws_route_table_association" "b" {
    # Please note that one of either subnet_id or gateway_id is required.
    route_table_id = aws_route_table.public-rt.id        # (Required) The ID of the routing table to associate with.
    subnet_id      = aws_subnet.public-subnet-001.id      # (Optional) The subnet ID to create an association. Conflicts with gateway_id.
    # gateway_id   = ""                                   # (Optional) The gateway ID to create an association. Conflicts with subnet_id.
}