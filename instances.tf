locals {
  acpcicd_tag = "${var.name_prefix}acpcicd-"
  acpops_tag  = "${var.name_prefix}acpops-"
  acpprod_tag = "${var.name_prefix}acpprod-"
  acpvpn_tag  = "${var.name_prefix}acpvpn-"
}

#### ACPCICD

module "ACPCICD" {
  source     = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data  = "LISTEN_http=0.0.0.0:80"
  subnet_id  = "${aws_subnet.acpcicd_subnet.id}"
  private_ip = "${var.acp_private_ips["cicd_tester_ip"]}"

  tags = {
    Name = "ec2-${var.service}-cicd-tester-${var.environment}"
  }
}

resource "aws_security_group" "acpcicd" {
  vpc_id = "${aws_vpc.acpcicdvpc.id}"

  tags {
    Name = "${local.acpcicd_tag}sg"
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "${var.route_table_cidr_blocks["peering_cidr"]}",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

#### ACPOPS

module "ACPOPS" {
  source     = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data  = "LISTEN_http=0.0.0.0:80"
  subnet_id  = "${aws_subnet.ACPOPSSubnet.id}"
  private_ip = "${var.acp_private_ips["ops_tester_ip"]}"

  tags = {
    Name = "ec2-${var.service}-ops-tester-${var.environment}"
  }
}

resource "aws_security_group" "ACPOPS" {
  vpc_id = "${aws_vpc.acpopsvpc.id}"

  tags {
    Name = "${local.acpops_tag}sg"
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "${var.route_table_cidr_blocks["peering_cidr"]}",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

#### ACPVPN

module "ACPVPN" {
  source     = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data  = "LISTEN_http=0.0.0.0:80"
  subnet_id  = "${aws_subnet.ACPVPNSubnet.id}"
  private_ip = "${var.acp_private_ips["vpn_tester_ip"]}"

  tags = {
    Name = "ec2-${var.service}-vpn-tester-${var.environment}"
  }
}

resource "aws_security_group" "ACPVPN" {
  vpc_id = "${aws_vpc.acpvpnvpc.id}"

  tags {
    Name = "${local.acpvpn_tag}sg"
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "${var.route_table_cidr_blocks["peering_cidr"]}",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

#### ACPPROD
module "ACPPROD" {
  source     = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data  = "LISTEN_http=0.0.0.0:80"
  subnet_id  = "${aws_subnet.acpprod_subnet.id}"
  private_ip = "${var.acp_private_ips["prod_tester_ip"]}"

  tags = {
    Name = "ec2-${var.service}-prod-tester-${var.environment}"
  }
}

resource "aws_security_group" "acpprod" {
  vpc_id = "${aws_vpc.acpprodvpc.id}"

  tags {
    Name = "${local.acpprod_tag}sg"
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "${var.route_table_cidr_blocks["peering_cidr"]}",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
