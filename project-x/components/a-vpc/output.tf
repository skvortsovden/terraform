output "vpc_id" {
  value = "${module.a-vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.a-vpc.vpc_cidr}"
}

output "default_route_table_id" {
  value = "${module.a-vpc.default_route_table_id}"
}

output "a_subnet_1_cidr_block" {
  value = "${module.a-subnet-1.cidr_block}"
}


