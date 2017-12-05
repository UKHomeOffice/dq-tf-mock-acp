locals {
  acpcicd_tag = "${var.name_prefix}acpcicd-"
  acpops_tag  = "${var.name_prefix}acpops-"
  acpprod_tag = "${var.name_prefix}acpprod-"
  acpvpn_tag  = "${var.name_prefix}acpvpn-"
}

#### ACPCICD

module "ACPCICD" {
  source    = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data = "CHECK_self=127.0.0.1:80 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
  subnet_id = "${aws_subnet.ACPCICDSubnet.id}"
}

resource "aws_security_group" "ACPCICD" {
  vpc_id = "${aws_vpc.acpcicdvpc.id}"

  tags {
    Name = "${local.acpcicd_tag}sg"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
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
  source    = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data = "CHECK_self=127.0.0.1:80 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
  subnet_id = "${aws_subnet.ACPOPSSubnet.id}"
}

resource "aws_security_group" "ACPOPS" {
  vpc_id = "${aws_vpc.acpopsvpc.id}"

  tags {
    Name = "${local.acpops_tag}sg"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
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
  source    = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data = "CHECK_self=127.0.0.1:80 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
  subnet_id = "${aws_subnet.ACPVPNSubnet.id}"
}

resource "aws_security_group" "ACPVPN" {
  vpc_id = "${aws_vpc.acpvpnvpc.id}"

  tags {
    Name = "${local.acpvpn_tag}sg"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
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
  source    = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data = "CHECK_self=127.0.0.1:80 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
  subnet_id = "${aws_subnet.ACPPRODSubnet.id}"
}

resource "aws_security_group" "ACPPROD" {
  vpc_id = "${aws_vpc.acpprodvpc.id}"

  tags {
    Name = "${local.acpprod_tag}sg"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
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
