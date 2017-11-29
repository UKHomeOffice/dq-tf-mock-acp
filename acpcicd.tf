locals {
  acpcicd_name_prefix = "${var.name_prefix}acpcicd-"
}

resource "aws_vpc" "acpcicdvpc" {
  cidr_block = "${var.acpcicd_cidr_block}"

  tags {
    Name = "${local.acpcicd_name_prefix}vpc"
  }
}

resource "aws_internet_gateway" "ACPCICDRouteToInternet" {
  vpc_id = "${aws_vpc.acpcicdvpc.id}"

  tags {
    Name = "${local.acpcicd_name_prefix}igw"
  }
}

resource "aws_subnet" "ACPCICDSubnet" {
  vpc_id                  = "${aws_vpc.acpcicdvpc.id}"
  cidr_block              = "${var.acpcicd_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.acpcicd_name_prefix}subnet"
  }
}
