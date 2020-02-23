output "vpc_id" {
  value = "${module.b-vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.b-vpc.vpc_cidr}"
}

output "default_route_table_id" {
  value = "${module.b-vpc.default_route_table_id}"
}

output "b_subnet_1_cidr_block" {
  value = "${module.b-subnet-1.cidr_block}"
}

output "b_subnet_2_cidr_block" {
  value = "${module.b-subnet-2.cidr_block}"
}
