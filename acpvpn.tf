variable "cidr_block" {}
variable "vpc_subnet_cidr_block" {}
variable "az" {}
variable "name_prefix" {}

locals {
  name_prefix = "${var.name_prefix}acpvpn-"
}

resource "aws_vpc" "acpvpnvpc" {
  cidr_block = "${var.cidr_block}"

  tags {
    Name = "${local.name_prefix}VPC"
  }
}

resource "aws_internet_gateway" "ACPVPNRouteToInternet" {
  vpc_id = "${aws_vpc.acpvpnvpc.id}"

  tags {
    Name = "${local.name_prefix}IGW"
  }
}

resource "aws_subnet" "ACPVPNSubnet" {
  vpc_id                  = "${aws_vpc.acpvpnvpc.id}"
  cidr_block              = "${var.vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.name_prefix}subnet"
  }
}
