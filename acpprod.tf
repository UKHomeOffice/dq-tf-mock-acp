locals {
  prod_naming_suffix = "prod-${local.naming_suffix}"
}

resource "aws_vpc" "acpprodvpc" {
  cidr_block = "${var.acpprod_cidr_block}"

  tags {
    Name = "vpc-${local.prod_naming_suffix}"
  }
}

resource "aws_internet_gateway" "acp_prod_igw" {
  vpc_id = "${aws_vpc.acpprodvpc.id}"

  tags {
    Name = "igw-${local.prod_naming_suffix}"
  }
}

resource "aws_subnet" "acpprod_subnet" {
  vpc_id                  = "${aws_vpc.acpprodvpc.id}"
  cidr_block              = "${var.acpprod_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "subnet-${local.prod_naming_suffix}"
  }
}

resource "aws_route_table" "acpprod_route_table" {
  vpc_id = "${aws_vpc.acpprodvpc.id}"

  route {
    cidr_block                = "${var.route_table_cidr_blocks["peering_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpprod"]}"
  }

  route {
    cidr_block                = "${var.route_table_cidr_blocks["ops_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpprod"]}"
  }

  route {
    cidr_block                = "${var.route_table_cidr_blocks["apps_cidr"]}"
    vpc_peering_connection_id = "${var.vpc_peering_connection_ids["peering_and_acpprod"]}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.acp_prod_igw.id}"
  }

  tags {
    Name = "route-table-${local.prod_naming_suffix}"
  }
}

resource "aws_route_table_association" "acp_prod_rt_assocation" {
  subnet_id      = "${aws_subnet.acpprod_subnet.id}"
  route_table_id = "${aws_route_table.acpprod_route_table.id}"
}
