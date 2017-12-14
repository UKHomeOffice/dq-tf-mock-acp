locals {
  acpcicd_name_prefix = "${var.name_prefix}acpcicd-"
}

resource "aws_vpc" "acpcicdvpc" {
  cidr_block = "${var.acpcicd_cidr_block}"

  tags {
    Name = "${local.acpcicd_name_prefix}vpc"
  }
}

resource "aws_internet_gateway" "acp_cicd_igw" {
  vpc_id = "${aws_vpc.acpcicdvpc.id}"

  tags {
    Name = "${local.acpcicd_name_prefix}igw"
  }
}

resource "aws_subnet" "acpcicd_subnet" {
  vpc_id                  = "${aws_vpc.acpcicdvpc.id}"
  cidr_block              = "${var.acpcicd_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.acpcicd_name_prefix}subnet"
  }
}

resource "aws_route_table" "acpcicd_route_table" {
  vpc_id = "${aws_vpc.acpcicdvpc.id}"

  route {
    cidr_block                = "${var.route_table_cidr_blocks["peering_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpcicd"]}"
  }

  route {
    cidr_block                = "${var.route_table_cidr_blocks["ops_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpcicd"]}"
  }

  route {
    cidr_block                = "${var.route_table_cidr_blocks["apps_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpcicd"]}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.acp_cicd_igw.id}"
  }

  tags {
    Name = "${local.acpcicd_name_prefix}route-table"
  }
}

resource "aws_route_table_association" "acp_cicd_rt_assocation" {
  subnet_id      = "${aws_subnet.acpcicd_subnet.id}"
  route_table_id = "${aws_route_table.acpcicd_route_table.id}"
}
