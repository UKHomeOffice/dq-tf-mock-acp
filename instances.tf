variable instance_type {
  default = "t2.nano"
}

data "aws_ami" "linux_connectivity_tester" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "connectivity-tester-linux*",
    ]
  }

  owners = [
    "093401982388",
  ]
}

locals {
  acpcicd_tag = "${var.name_prefix}acpcicd-"
  acpops_tag  = "${var.name_prefix}acpops-"
  acpprod_tag = "${var.name_prefix}acpprod-"
  acpvpn_tag  = "${var.name_prefix}acpvpn-"
}

#### ACPCICD

resource "aws_instance" "BastionHostLinuxACPCICD" {
  ami                    = "${data.aws_ami.linux_connectivity_tester.id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.ACPCICDSubnet.id}}"
  vpc_security_group_ids = ["${aws_security_group.BastionsACPCICD.id}"]

  tags {
    Name = "${local.acpcicd_tag}ec2-linux"
  }

  user_data = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
}

resource "aws_security_group" "BastionsACPCICD" {
  vpc_id = "${aws_vpc.acpcicdvpc.id}"

  tags {
    Name = "${local.acpcicd_tag}sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#### ACPOPS

resource "aws_instance" "BastionHostLinuxACPOPS" {
  ami                    = "${data.aws_ami.linux_connectivity_tester.id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.ACPOPSSubnet.id}}"
  vpc_security_group_ids = ["${aws_security_group.BastionsACPOPS.id}"]

  tags {
    Name = "${local.acpops_tag}ec2-linux"
  }

  user_data = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
}

resource "aws_security_group" "BastionsACPOPS" {
  vpc_id = "${aws_vpc.acpopsvpc.id}"

  tags {
    Name = "${local.acpops_tag}sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#### ACPVPN

resource "aws_instance" "BastionHostLinuxACPVPN" {
  ami                    = "${data.aws_ami.linux_connectivity_tester.id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.ACPVPNSubnet.id}}"
  vpc_security_group_ids = ["${aws_security_group.BastionsACPVPN.id}"]

  tags {
    Name = "${local.acpvpn_tag}ec2-linux"
  }

  user_data = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
}

resource "aws_security_group" "BastionsACPVPN" {
  vpc_id = "${aws_vpc.acpvpnvpc.id}"

  tags {
    Name = "${local.acpvpn_tag}sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#### ACPPROD

resource "aws_instance" "BastionHostLinuxACPPROD" {
  ami                    = "${data.aws_ami.linux_connectivity_tester.id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.ACPPRODSubnet.id}}"
  vpc_security_group_ids = ["${aws_security_group.BastionsACPPROD.id}"]

  tags {
    Name = "${local.acpprod_tag}ec2-linux"
  }

  user_data = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_http=0.0.0.0:80"
}

resource "aws_security_group" "BastionsACPPROD" {
  vpc_id = "${aws_vpc.acpprodvpc.id}"

  tags {
    Name = "${local.acpprod_tag}sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
