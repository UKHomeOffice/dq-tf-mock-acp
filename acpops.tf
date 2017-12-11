locals {
  acpops_name_prefix = "${var.name_prefix}acpops-"
}

resource "aws_vpc" "acpopsvpc" {
  cidr_block = "${var.acpops_cidr_block}"

  tags {
    Name = "${local.acpops_name_prefix}vpc"
  }
}

resource "aws_route_table" "acpops_route_table" {
  vpc_id = "${aws_vpc.acpopsvpc.id}"

  tags {
    Name = "${local.acpops_name_prefix}route-table"
  }
}

resource "aws_subnet" "ACPOPSSubnet" {
  vpc_id                  = "${aws_vpc.acpopsvpc.id}"
  cidr_block              = "${var.acpops_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.acpops_name_prefix}subnet"
  }
}
