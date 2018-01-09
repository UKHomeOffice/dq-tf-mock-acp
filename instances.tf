module "ACPCICD" {
  source                      = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data                   = "LISTEN_http=0.0.0.0:80 CHECK_http=${var.tester_ips["peering_tester_ip"]}:${var.tester_ports["peering_http_port"]} CHECK_ext_tableau=${var.tester_ips["ext_tableau"]}:${var.tester_ports["ext_tableau_port"]} CHECK_int_tableau=${var.tester_ips["int_tableau"]}:${var.tester_ports["int_tableau_port"]} CHECK_bdm_web=${var.tester_ips["bdm_web"]}:${var.tester_ports["bdm_web_port"]} CHECK_gp_master=${var.tester_ips["gp_master"]}:${var.tester_ports["gp_master_port"]}"
  subnet_id                   = "${aws_subnet.acpcicd_subnet.id}"
  private_ip                  = "${var.acp_private_ips["cicd_tester_ip"]}"
  security_groups             = ["${aws_security_group.acpcicd.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "tester-${local.acpcicd_naming_suffix}"
  }
}

resource "aws_security_group" "acpcicd" {
  vpc_id = "${aws_vpc.acpcicdvpc.id}"

  tags {
    Name = "sg-${local.acpcicd_naming_suffix}"
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

module "ACPOPS" {
  source                      = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data                   = "LISTEN_http=0.0.0.0:80 CHECK_http=${var.tester_ips["peering_tester_ip"]}:${var.tester_ports["peering_http_port"]}  CHECK_ext_tableau=${var.tester_ips["ext_tableau"]}:${var.tester_ports["ext_tableau_port"]} CHECK_int_tableau=${var.tester_ips["int_tableau"]}:${var.tester_ports["int_tableau_port"]} CHECK_bdm_web=${var.tester_ips["bdm_web"]}:${var.tester_ports["bdm_web_port"]} CHECK_gp_master=${var.tester_ips["gp_master"]}:${var.tester_ports["gp_master_port"]}"
  subnet_id                   = "${aws_subnet.acpops_subnet.id}"
  private_ip                  = "${var.acp_private_ips["ops_tester_ip"]}"
  security_groups             = ["${aws_security_group.acpops.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "tester-${local.acpops_naming_suffix}"
  }
}

resource "aws_security_group" "acpops" {
  vpc_id = "${aws_vpc.acpopsvpc.id}"

  tags {
    Name = "sg-${local.acpops_naming_suffix}"
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
  source                      = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data                   = "LISTEN_http=0.0.0.0:80 CHECK_rdp=${var.tester_ips["ops_win_tester_ip"]}:${var.tester_ports["ops_rdp_port"]} CHECK_ssh=${var.tester_ips["ops_linux_tester_ip"]}:${var.tester_ports["ops_ssh_port"]}"
  subnet_id                   = "${aws_subnet.acpvpn_subnet.id}"
  private_ip                  = "${var.acp_private_ips["vpn_tester_ip"]}"
  security_groups             = ["${aws_security_group.acpvpn.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "tester-${local.acpvpn_naming_suffix}"
  }
}

resource "aws_security_group" "acpvpn" {
  vpc_id = "${aws_vpc.acpvpnvpc.id}"

  tags {
    Name = "sg-${local.acpvpn_naming_suffix}"
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "${var.route_table_cidr_blocks["ops_cidr"]}",
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
  source                      = "github.com/UKHomeOffice/connectivity-tester-tf"
  user_data                   = "LISTEN_http=0.0.0.0:80 CHECK_http=${var.tester_ips["peering_tester_ip"]}:${var.tester_ports["peering_http_port"]}  CHECK_ext_tableau=${var.tester_ips["ext_tableau"]}:${var.tester_ports["ext_tableau_port"]} CHECK_int_tableau=${var.tester_ips["int_tableau"]}:${var.tester_ports["int_tableau_port"]} CHECK_bdm_web=${var.tester_ips["bdm_web"]}:${var.tester_ports["bdm_web_port"]} CHECK_gp_master=${var.tester_ips["gp_master"]}:${var.tester_ports["gp_master_port"]}"
  subnet_id                   = "${aws_subnet.acpprod_subnet.id}"
  private_ip                  = "${var.acp_private_ips["prod_tester_ip"]}"
  security_groups             = ["${aws_security_group.acpprod.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "tester-${local.acpprod_naming_suffix}"
  }
}

resource "aws_security_group" "acpprod" {
  vpc_id = "${aws_vpc.acpprodvpc.id}"

  tags {
    Name = "sg-${local.acpprod_naming_suffix}"
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
