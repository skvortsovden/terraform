output "vpc_id" {
   description = "VPC created with module"
   value       = "${aws_vpc.vpc.id}"
}
output "vpc_cidr" {
  value = "${var.cidr}"
}

output "default_route_table_id" {
    description = "VPC default route table id"
    value       = "${aws_vpc.vpc.default_route_table_id}"
}
