locals {
  acpops_name_prefix = "${var.name_prefix}acpops-"
}

resource "aws_vpc" "acpopsvpc" {
  cidr_block = "${var.acpops_cidr_block}"

  tags {
    Name = "${local.acpops_name_prefix}vpc"
  }
}

resource "aws_subnet" "acpops_subnet" {
  vpc_id                  = "${aws_vpc.acpopsvpc.id}"
  cidr_block              = "${var.acpops_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.acpops_name_prefix}subnet"
  }
}

resource "aws_internet_gateway" "acp_ops_igw" {
  vpc_id = "${aws_vpc.acpopsvpc.id}"

  tags {
    Name = "${local.acpops_name_prefix}igw"
  }
}

resource "aws_route_table" "acpops_route_table" {
  vpc_id = "${aws_vpc.acpopsvpc.id}"

  route {
    cidr_block                = "${var.route_table_cidr_blocks["peering_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpops"]}"
  }

  route {
    cidr_block                = "${var.route_table_cidr_blocks["ops_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpops"]}"
  }

  route {
    cidr_block                = "${var.route_table_cidr_blocks["apps_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpops"]}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.acp_ops_igw.id}"
  }

  tags {
    Name = "${local.acpops_name_prefix}route-table"
  }
}

resource "aws_route_table_association" "acp_ops_rt_assocation" {
  subnet_id      = "${aws_subnet.acpops_subnet.id}"
  route_table_id = "${aws_route_table.acpops_route_table.id}"
}
