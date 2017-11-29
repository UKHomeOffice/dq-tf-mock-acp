locals {
  acpvpn_name_prefix = "${var.name_prefix}acpvpn-"
}

resource "aws_vpc" "acpvpnvpc" {
  cidr_block = "${var.acpvpn_cidr_block}"

  tags {
    Name = "${local.acpvpn_name_prefix}vpc"
  }
}

resource "aws_subnet" "ACPVPNSubnet" {
  vpc_id                  = "${aws_vpc.acpvpnvpc.id}"
  cidr_block              = "${var.acpvpn_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.acpvpn_name_prefix}subnet"
  }
}
