resource "aws_default_security_group" "default" {
  vpc_id      = "${var.vpc_id}"

  ingress {
    # ICMP
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = "${var.in_icmp_cidr_blocks}"
  }

  ingress {
    # SSH
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = "${var.in_ssh_cidr_blocks}"
  }

}