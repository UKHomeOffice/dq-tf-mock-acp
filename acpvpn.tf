locals {
  vpn_naming_suffix = "vpn-${local.naming_suffix}"
}

resource "aws_vpc" "acpvpnvpc" {
  cidr_block = "${var.acpvpn_cidr_block}"

  tags {
    Name = "vpc-${local.vpn_naming_suffix}"
  }
}

resource "aws_subnet" "acpvpn_subnet" {
  vpc_id                  = "${aws_vpc.acpvpnvpc.id}"
  cidr_block              = "${var.acpvpn_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "subnet-${local.vpn_naming_suffix}"
  }
}

resource "aws_internet_gateway" "acpvpn_igw" {
  vpc_id = "${aws_vpc.acpvpnvpc.id}"

  tags {
    Name = "igw-${local.vpn_naming_suffix}"
  }
}

resource "aws_route_table" "acpvpn_route_table" {
  vpc_id = "${aws_vpc.acpvpnvpc.id}"

  route {
    cidr_block                = "${var.route_table_cidr_blocks["ops_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["ops_and_acpvpn"]}"
  }

  route {
    cidr_block                = "${var.route_table_cidr_blocks["apps_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["ops_and_acpvpn"]}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.acpvpn_igw.id}"
  }

  tags {
    Name = "route-table-${local.vpn_naming_suffix}"
  }
}

resource "aws_route_table_association" "acpvpn_rt_assocation" {
  subnet_id      = "${aws_subnet.acpvpn_subnet.id}"
  route_table_id = "${aws_route_table.acpvpn_route_table.id}"
}
