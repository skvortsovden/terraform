output "subnet_id" {
    description = "Id of craeted subnet"
    value       = "${aws_subnet.subnet.id}"
}
output "cidr_block" {
    description = "CIDR of created subnet"
    value       = "${aws_subnet.subnet.cidr_block}"
}