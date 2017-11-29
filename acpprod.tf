locals {
  acpprod_name_prefix = "${var.name_prefix}acpprod-"
}

resource "aws_vpc" "acpprodvpc" {
  cidr_block = "${var.acpprod_cidr_block}"

  tags {
    Name = "${local.acpprod_name_prefix}vpc"
  }
}

resource "aws_internet_gateway" "ACPPRODRouteToInternet" {
  vpc_id = "${aws_vpc.acpprodvpc.id}"

  tags {
    Name = "${local.acpprod_name_prefix}igw"
  }
}

resource "aws_subnet" "ACPPRODSubnet" {
  vpc_id                  = "${aws_vpc.acpprodvpc.id}"
  cidr_block              = "${var.acpprod_vpc_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.acpprod_name_prefix}subnet"
  }
}
