resource "aws_route" "r" {
  route_table_id            = "${var.route_table_id}"
  destination_cidr_block    = "${var.destination_cidr_block}"
  vpc_peering_connection_id = "${var.vpc_peering_connection_id}"
  gateway_id                = "${var.gateway_id}"
}